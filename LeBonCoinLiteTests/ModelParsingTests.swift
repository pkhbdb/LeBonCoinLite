//
//  ModelParsingTests.swift
//  LeBonCoinLiteTests
//
//  Created by Alexandre Guzu on 20/09/2021.
//

import XCTest

class ModelParsingTests: XCTestCase {

    func testAdsMapping() {
        if let path = Bundle(for: type(of: self)).path(forResource: "ads", ofType: "json") {
            do {
                var ads = [ClassifiedAd]()
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                if let classifiedAds = try? decoder.decode([ClassifiedAd].self, from: data) {
                    ads.append(contentsOf: classifiedAds)
                }
                XCTAssertTrue(ads.count == 300)
                XCTAssertTrue(ads[0].id == 1461267313)
                XCTAssertTrue(ads[0].categoryId == 4)
                XCTAssertTrue(ads[0].title == "Statue homme noir assis en plâtre polychrome")
                XCTAssertTrue(ads[0].description == "Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible")
                XCTAssertFalse(ads[0].isUrgent)
                let date = ISO8601DateFormatter().date(from: "2019-11-05T15:56:59+0000")
                XCTAssertTrue(ads[0].creationDate == date)
                XCTAssertTrue(ads[0].imagesUrl.small == "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")
                XCTAssertTrue(ads[0].imagesUrl.thumb == "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")

            } catch let error {
                XCTFail(error.localizedDescription)
            }
        } else {
            XCTFail("ads.json not found")
        }
    }

    func testCategoriesMapping() {
        if let path = Bundle(for: type(of: self)).path(forResource: "categories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let categories = try? decoder.decode([Category].self, from: data) else {
                    XCTFail("Error parsing categories.json")
                    return
                }
                XCTAssertTrue(categories.count == 11)
                XCTAssertTrue(categories[0].id == 1)
                XCTAssertTrue(categories[0].name == "Véhicule")

            } catch let error {
                XCTFail(error.localizedDescription)
            }
        } else {
            XCTFail("categories.json not found")
        }
    }

}
