//
//  ContentView.swift
//  NotesApp
//
//  Created by Rassul Bessimbekov on 13.12.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Similar to React's useContext hook - gives access to the data store
    @Environment(\.modelContext) private var modelContext
    
    // Similar to React Query or Redux selector with automatic reactivity
    // Like: const notes = useSelector(state => state.notes.sort((a, b) => b.date - a.date))
    @Query(sort: \Note.modificationDate, order: .reverse) private var notes: [Note]
    
    // Similar to React's useState hook
    // const [searchText, setSearchText] = useState("")
    @State private var searchText = ""
    
    // Computed property - like a React useMemo or useCallback
    // Similar to: const filteredNotes = useMemo(() => {
    //   if (!searchText) return notes;
    //   return notes.filter(note => note.title.includes(searchText))
    // }, [notes, searchText])
    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return notes
        }
        return notes.filter { note in
            note.title.localizedCaseInsensitiveContains(searchText) ||
            note.content.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    // Another computed property that groups notes by date
    // Similar to Array.reduce() in JavaScript to group items
    var groupedNotes: [(String, [Note])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: filteredNotes) { note in
            if calendar.isDateInToday(note.modificationDate) {
                return "Today"
            } else if calendar.isDateInYesterday(note.modificationDate) {
                return "Yesterday"
            } else if calendar.isDate(note.modificationDate, equalTo: Date(), toGranularity: .weekOfYear) {
                return "Past Week"
            } else {
                return "Earlier"
            }
        }
        return grouped.sorted { $0.0 < $1.0 }
    }
    
    // Body is like the render method in React components
    var body: some View {
        // NavigationStack is similar to React Router's BrowserRouter
        NavigationStack {
            // List is similar to mapping over an array in React
            // but with built-in virtualization and native iOS styling
            List {
                // ForEach is similar to JavaScript's array.map()
                ForEach(groupedNotes, id: \.0) { section in
                    // Section is like a <section> or <div> with special iOS styling
                    Section(header: Text(section.0)) {
                        ForEach(section.1) { note in
                            // NavigationLink is similar to React Router's <Link>
                            NavigationLink {
                                NoteEditorView(note: note)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(note.title.isEmpty ? "New Note" : note.title)
                                        .font(.headline)
                                    if !note.content.isEmpty {
                                        Text(note.content)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .lineLimit(2)
                                    }
                                }
                            }
                        }
                        // Similar to implementing delete in React with filter
                        .onDelete { indexSet in
                            for index in indexSet {
                                modelContext.delete(section.1[index])
                            }
                        }
                    }
                }
            }
            // .searchable is like adding an input field with onChange handler
            .searchable(text: $searchText, prompt: "Search notes")
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Button with action is similar to onClick in React
                    Button {
                        let note = Note()
                        modelContext.insert(note)
                    } label: {
                        Label("Add Note", systemImage: "square.and.pencil")
                    }
                }
            }
        }
    }
}

// Preview is similar to Storybook stories in React
#Preview {
    ContentView()
        .modelContainer(for: Note.self, inMemory: true)
}
