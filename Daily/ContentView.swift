//
//  ContentView.swift
//  Daily
//
//  Created by Jonathan Gentry on 2/25/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.createdDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var todoText = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { (item: Item) in
                        ItemView(item: item)
                    }
                    .onDelete(perform: deleteItems)
                }
                Divider()
                
                HStack {
                    TextField("Add new to do...", text: $todoText)
                    Button {
                        addItem()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 35))
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                
                Divider()
            }
            .navigationBarTitle("ToDo")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.createdDate = Date()
            newItem.title = todoText
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
