//
//  InputView.swift
//  SLCalc
//
//  Created by Kristian Myhre on 07/07/2020.
//  Copyright © 2020 Kristian Myhre. All rights reserved.
//

import SwiftUI

struct InputView: View {
    
    @State var showingAdd = false
    @State var showingPref = false
    @State var modifiedMethod: Bool = false
    @EnvironmentObject var election: Election
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                List {
                    ForEach (election.partiesArray) { party in
                        partyCell(party: party)
                    }
                    
                    // Testing area begin
                    Text("bear", comment: "Name of an animal")
                    Button {
                        election.partiesArray = Constants.alternativTestData
                    } label: {
                        Text("Populate with test data")
                    }
                    Button {
                        election.partiesArray = Constants.testData
                    } label: {
                        Text("Populate with Norwegian test data")
                    }
                    
                    // Testing area end
                    
                        HStack {
                            Spacer()
                            if election.partiesArray.isEmpty {
                            Text("Add a party using the + button")
                                .foregroundColor(.secondary)
                            } else {
                                Text("\(election.partiesArray.count) parties")
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }

                    
                }
                .listStyle(InsetGroupedListStyle())
                // First row of navbar shenanigans
                .navigationBarTitle(LocalizedStringKey("Parties"))
                .navigationBarItems(
                    leading:
                        Button(action: {
                            self.showingPref.toggle()
                        }) {
                            Image(systemName: "gear")
                                .imageScale(.large)
                        }.sheet(isPresented: $showingPref) {
                            SideBar(showingPref: $showingPref).environmentObject(election)
                        }

                        .padding(),
                    trailing:
                        Button(action: {
                            self.showingAdd.toggle()
                        }) {
                            Image(systemName: "plus")
                            imageScale(.large)
                        }.sheet(isPresented: $showingAdd) {
                            AddParty(showingAdd: $showingAdd).environmentObject(election)
                        }
                )
                NavigationLink("Calculate Election", destination: ResultsView().environmentObject(election))
                    .padding()
                    .disabled(election.partiesArray.isEmpty)
            }
        }
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
            .preferredColorScheme(.light)
    }
}


struct partyCell: View {
    var party: Party
    var body: some View {
        HStack {
            
            Text(party.partyName)
            Spacer()
            Text("\(party.votesFormatted) votes")
                .font(.footnote)
            
        }
    }
}
