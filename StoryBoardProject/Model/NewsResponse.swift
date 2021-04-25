import Foundation




struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID()
    let source: Source
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
extension Article{
    static var dummySource:Source{
        .init(id: nil, name: "Telegraaf.nl")
    }
    static var dummyData: Article{
        .init(source: dummySource,
              author: "onze correspondent",
              title: "Elon Musk gaat Saturday Night Live presenteren"
              , articleDescription: "Elon Musk, topman van Tesla en ruimtevaartbedrijf SpaceX, maakt zijn presentatiedebuut. Op 8 mei gaat hij Saturday Night Live presenteren."
              , url: "https://www.telegraaf.nl/entertainment/2144697723/elon-musk-gaat-saturday-night-live-presenteren"
              , urlToImage: "https://www.telegraaf.nl/images/1200x630/filters:format(jpeg):quality(80)/cdn-kiosk-api.telegraaf.nl/ae69722c-a53e-11eb-ae76-02c309bc01c1.jpg"
              , publishedAt: Date()
              , content: "Het gebeurt niet vaak dat een ondernemer de talkshow op NBC mag hosten. Eerder gingen onder meer George Steinbrenner, eigenaar van New York Yankees, en voormalig NBC-baas Brandon Tartikoff de 49-jari… [+273 chars]")
    }
}
