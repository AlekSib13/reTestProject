//
//  RealmDBManager.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 02.11.2022.
//

import Foundation
import RealmSwift

protocol BaseRealm {}

extension BaseRealm {
    var realmDB: Realm {try! Realm()}
}
protocol RealmDBManagerProtocol: AnyObject {}
protocol BasicRealmManagerProtocol {
    func writeUserScoreRmModelToDB(id: String, data: RmUserScoreData, callback: @escaping (Result<Bool, Error>) -> Void)
    func readUserScoreRmModelFromDB(id: String, callback: @escaping (Result<RmUserScoreData, Error>) -> Void)
}

class RealmDBManager: RealmDBManagerProtocol {
    static let shared = RealmDBManager()
    
    private init() {}
    
    func initialiseDB() {
        do {
            let file = try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension("reTest.realm")
            
            //to facilitate the development of the app the migration to new versions is switched off
            Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: file, inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: nil, objectTypes: nil)
            
            print("Realm: \(Realm.Configuration.defaultConfiguration.fileURL!)")
        } catch {
            let error = BaseErrors(errorType: .realmInitialSetting, errorTitle: "Could not initialise DB", descritpion: nil)
            assertionFailure(error.errorTitle)
        }
    }
}

extension RealmDBManager: BaseRealm, BasicRealmManagerProtocol {
    
    func writeUserScoreRmModelToDB(id: String, data: RmUserScoreData, callback: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let self = self else {return}
            do {
                try self.realmDB.write {
                    self.realmDB.add(data, update: .all)
                    DispatchQueue.main.async {
                        callback(.success(true))
                    }
                }
            } catch {
                let error = BaseErrors(errorType: .realmWritingError, errorTitle: "Could not write RmUserScoreData object to realm", descritpion: nil)
                assertionFailure(error.errorTitle)
                DispatchQueue.main.async {
                    callback(.failure(error))
                }
            }
        }
    }

    func readUserScoreRmModelFromDB(id: String, callback: @escaping (Result<RmUserScoreData, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let self = self else {return}
            let realmObject = self.realmDB.objects(RmUserScoreData.self).where {$0.id == id}.first
            if let realmObject {
                let realmObjectSafe = ThreadSafeReference(to: realmObject)
                DispatchQueue.main.async {
                    let realm = try! Realm()
                    if let realmObjectResolved = realm.resolve(realmObjectSafe) {
                        callback(.success(realmObjectResolved))
                    } else {
                        let error = BaseErrors(errorType: .dbThreadSafeError, errorTitle: "Could not resolve threadsafe object", descritpion: nil)
                        assertionFailure(error.errorTitle)
                    }
                }
            } else {
                let error = BaseErrors(errorType: .noDataInDB, errorTitle: "There is no UserScore data in db", descritpion: nil)
                assertionFailure(error.errorTitle)
                DispatchQueue.main.async {
                    callback(.failure(error))
                }
            }
        }
    }
}
