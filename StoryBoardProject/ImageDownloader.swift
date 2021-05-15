//
//  ImageDownloader.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 12.04.2021.
//

import Foundation
import SwiftUI
import UIKit
import Combine




struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    @ObservedObject var numOfCards:NumberOfCards
    
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:),
        numOfCards: NumberOfCards
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
        self .numOfCards = numOfCards
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
       
        Group {
            if loader.image != nil {
                
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    
    private let url: URL
    private var cache: ImageCache?
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else { return }

        if let image = cache?[url] {
            self.image = image

            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        //if UserDefaults.standard.object(forKey: "images") != nil{
//            var imagesUserDefaults = UserDefaults.standard.object(forKey: "images") as! [UIImage] ?? []
//            imagesUserDefaults.append(image!)
//            print("Here is what inside the images:")
//            print(imagesUserDefaults)
//        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: imagesUserDefaults as NSArray)
//                UserDefaults.standard.set(archivedObject, forKey: "images")
//                UserDefaults.standard.synchronize()
        var counter = UserDefaults.standard.integer(forKey: "imageCounter") ?? 0
        counter = counter + 1
        UserDefaults.standard.set(counter, forKey: "imageCounter")
        
        do { try ImageStore.store(image: image!, name: "image\(counter)")
        } catch{
            print("Error during image storing to local ")
        }
        
        //}
//        else{
//            var imagesUserDefaults = Array<UIImage>()
//            let encodedData = NSKeyedArchiver.archivedData(withRootObject: imagesUserDefaults)
//            UserDefaults.standard.set(encodedData, forKey: "images")
//        }
        print("Print image content")
        for index in 1...counter {
            print("The \(index) image is")
        print(ImageStore.retrieve(imageNamed: "image\(index)"))
        
        }
        
        isLoading = false
        
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}


