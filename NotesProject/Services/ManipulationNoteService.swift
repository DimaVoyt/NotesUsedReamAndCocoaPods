//
//  ManipulationNoteService.swift
//  NotesProject
//
//  Created by Дмитрий Войтович on 05.05.2022.
//

import Foundation
import RealmSwift

let realmConfig = Realm.Configuration(schemaVersion: 2)

class ManipulationNoteService {
    func notes() -> Results<RealmObjectNotesInfo> {
        let realm = try! Realm(configuration: realmConfig)
        return realm.objects(RealmObjectNotesInfo.self)
    }
    
    func saveInfoNotes(nameText: String, noteText: String) {
        let realm = try! Realm(configuration: realmConfig)
        let note = RealmObjectNotesInfo()
        note.noteText = noteText
        note.noteName = nameText
        try! realm.write {
            realm.add(note)
        }
    }
    
    func updateNote(id: String, update: (RealmObjectNotesInfo) -> Void) {
        let realm = try! Realm(configuration: realmConfig)
        
        if let note = realm.object(ofType: RealmObjectNotesInfo.self, forPrimaryKey: id) {
            try! realm.write {
                update(note)
            }
        }
    }
    
    func deleteNote(id: String) {
        let realm = try! Realm(configuration: realmConfig)
        
        if let note = realm.object(ofType: RealmObjectNotesInfo.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(note)
            }
        }
    }
}



