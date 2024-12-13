import SwiftUI

struct NoteEditorView: View {
    // @Bindable is similar to React's props with two-way binding
    // Like combining value and onChange in a controlled component
    @Bindable var note: Note
    
    // Similar to React Router's useNavigate hook for going back
    @Environment(\.dismiss) private var dismiss
    
    // Similar to React's useRef for focusing elements
    // But with more native integration and type safety
    @FocusState private var focusedField: Field?
    
    // Similar to TypeScript enum or JavaScript object for constants
    enum Field {
        case title
        case content
    }
    
    // Body is like the render method in React components
    var body: some View {
        // VStack is similar to a flexbox container with flex-direction: column
        VStack(spacing: 0) {
            // TextField is similar to <input type="text"> in React
            // $note.title is like value={note.title} onChange={e => setNote({...note, title: e.target.value})}
            TextField("Title", text: $note.title)
                .font(.title2)
                .textFieldStyle(.plain)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .focused($focusedField, equals: .title)
            
            // Divider is like <hr> or a border in CSS
            Divider()
            
            // TextEditor is similar to <textarea> in React
            TextEditor(text: $note.content)
                .font(.body)
                .padding(.horizontal, 12)
                .focused($focusedField, equals: .content)
                .scrollContentBackground(.hidden)
        }
        // Similar to setting props on a parent container
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // Similar to a button with onClick in React
                Button("Done") {
                    note.modificationDate = Date()
                    dismiss()
                }
            }
        }
        // Similar to useEffect in React for side effects
        .onAppear {
            // Auto-focus logic similar to useEffect(() => { inputRef.current?.focus() }, [])
            focusedField = note.title.isEmpty ? .title : .content
        }
    }
} 