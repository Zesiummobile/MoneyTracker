//
//  RealmMapper.swift
//  MoneyTracker
//
//  Created by Zesium on 11/8/17.
//  Copyright © 2017 Zesium. All rights reserved.
//

import RealmSwift

/// RealmMapper - Realm CRUD operations

class RealmMapper {

    typealias AmountCurrency = (amount: Double, currency: String)

    // MARK: - Get methods

    static func getAmount(with categoryId: Int, from startTime: Date, to endTime: Date) -> [AmountCurrency] {

        do {
            let realm = try Realm()

            let predicte = NSPredicate(format: "(categoryId = %d) AND (date >= %@) AND (date <= %@)", categoryId,
                                       startTime as NSDate, endTime as NSDate)

            let entries = realm.objects(Entry.self).filter(predicte)

            var amounts = [String: Double]()
            for entry in entries {
                if amounts.keys.contains(entry.currency) {
                    let amount = amounts[entry.currency] ?? 0
                    amounts[entry.currency] = amount + entry.value
                } else {
                    amounts[entry.currency] = entry.value
                }
            }

            var amountsRet = [AmountCurrency]()
            for amountsKey in amounts.keys {
                amountsRet.append((amount: amounts[amountsKey] ?? 0, currency: amountsKey))
            }

            return amountsRet

        } catch let error as NSError {
            debugPrint(error)
        }

        return []
    }

    static func getEntries(from startTime: Date, to endTime: Date) -> [Entry] {

        do {
            let realm = try Realm()

            let predicte = NSPredicate(format: "(date >= %@) AND (date <= %@)",
                                       startTime as NSDate, endTime as NSDate)

            let entries = realm.objects(Entry.self).filter(predicte)

            if let entryList = Array(entries).map({$0.copy()}) as? [Entry] {
                return entryList
            }
        } catch let error as NSError {
            debugPrint(error)
        }

        return []
    }

    class func getEntryIdIncremeter() -> Int {

        do {
            let realm = try Realm()

            let maxId = (realm.objects(Entry.self).max(ofProperty: "id") as Int?) ?? -1
            return maxId + 1

        } catch let error as NSError {
            debugPrint(error)
        }

        return 0

    }

    class func getSettings() -> Settings? {
        do {
            let realm = try Realm()

            if let settings = realm.objects(Settings.self).first {
                return settings.copy() as? Settings
            }

        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        return nil
    }

    class func getCategory(with id: Int) -> Category? {
        do {
            let realm = try Realm()

            let category = realm.object(ofType: Category.self, forPrimaryKey: id)

            return category?.copy() as? Category
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        return nil
    }

    class func getCategories(state: Category.CategoryState) -> [Category] {
        do {
            let realm = try Realm()

            let categories = realm.objects(Category.self).filter(NSPredicate(format: "stateInt = %d", state.rawValue))

            if let categoryList = Array(categories).map({$0.copy()}) as? [Category] {
                return categoryList
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        return []
    }

    // MARK: - Delete methods

    class func deleteEntry(with id: Int) -> Bool {
        do {
            let realm = try Realm()

            if let entry = realm.object(ofType: Entry.self, forPrimaryKey: id) {
                try realm.write {
                    realm.delete(entry)
                }
                return true
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }

        return false
    }

    // MARK: - Save methods

    class func save(entry: Entry) {
        do {
            let realm = try Realm()

            try realm.write {
                realm.add(entry, update: true)
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
    }

    class func save(passcode: String) {
        do {
            let realm = try Realm()

            if let settings = realm.objects(Settings.self).first {
                try realm.write {
                    settings.passcode = passcode
                }
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
    }

    class func saveSetting(type: SettingCellViewModelFromDB.SettingCellType, newState: Int) {
        do {
            let realm = try Realm()

            if let settings = realm.objects(Settings.self).first {
                try realm.write {
                    switch type {
                    case .currency:
                        settings.currencyInt = newState
                    case .timePeriod:
                        settings.timePeriodInt = newState
                    case .passcodeEnabled:
                        settings.passcodeEnabled = newState
                    }
                }
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
    }

    // MARK: - Add default data

    class func addDefaultCategories() {
        do {
            let realm = try Realm()

            let categories = realm.objects(Category.self)

            if categories.isEmpty {
                let fuelCategory = Category()
                fuelCategory.id = 1
                fuelCategory.image = "fuel-icon"
                fuelCategory.name = "Fuel"
                fuelCategory.state = .normal

                let foodCategory = Category()
                foodCategory.id = 2
                foodCategory.image = "food-icon"
                foodCategory.name = "Food"
                foodCategory.state = .normal

                let clothesCategory = Category()
                clothesCategory.id = 3
                clothesCategory.image = "clothes-icon"
                clothesCategory.name = "Clothes"
                clothesCategory.state = .normal

                let sportCategory = Category()
                sportCategory.id = 4
                sportCategory.image = "sport-icon"
                sportCategory.name = "Sport"
                sportCategory.state = .normal

                try realm.write {
                    realm.add([fuelCategory, foodCategory, clothesCategory, sportCategory])
                }
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
    }

    class func addDefaultSetting() {
        do {
            let realm = try Realm()

            let settings = realm.objects(Settings.self)

            if settings.isEmpty {
                let newSettings = Settings()

                try realm.write {
                    realm.add(newSettings)
                }
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
    }
}
