//
//  RealmClass.swift
//  NotesProject
//
//  Created by Дмитрий Войтович on 04.05.2022.
//

import Foundation
import RealmSwift

class RealmObjectNotesInfo: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var noteName: String
    @Persisted var noteText: String
    @Persisted var dateTs: Double = Date().timeIntervalSince1970
}
