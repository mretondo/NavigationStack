//
//  ContentView.swift
//  NavigationStack
//
//  Created by Mike Retondo on 1/6/24.
//

import SwiftUI

struct CarBrand: Identifiable, Hashable {
    let id = NSUUID().uuidString
    let name: String
}

struct Car: Identifiable, Hashable {
    let id = NSUUID().uuidString
    let make: String
    let model: String
    let year: Int

    var description: String {
        return "\(year) \(make) \(model)"
    }
}

struct ContentView: View {
    let brands: [CarBrand] = [
        .init(name: "Ferrari"),
        .init(name: "Lamborghini"),
        .init(name: "Mercedes"),
        .init(name: "Aston Martin")
    ]

    let cars: [Car] = [
        .init(make: "Ferrari", model: "480", year: 2022),
        .init(make: "Lamborghini", model: "Aventador", year: 2023),
        .init(make: "Mercedes", model: "AMG 63", year: 2019),
        .init(make: "Aston Martin", model: "Vantage", year: 2021),
    ]

    @State private var navigationPath = [CarBrand]()
    @State private var showFullStack = false

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                List {
                    Section("Manufacturers") {
                        ForEach(brands) { brand in
                            NavigationLink(value: brand) {
                                Text (brand.name)
                            }
                        }
                    }

                    Section("Cars") {
                        ForEach(cars) { car in
                            NavigationLink(value: car) {
                                Text (car.description)
                            }
                        }
                    }
                }
                .navigationDestination(for: CarBrand.self) { brand in
                    VStack {
                        viewForBrand(brand)

                        Button {
                            navigationPath = []
                        } label: {
                            Text("Go to root")
                        }

                    }
                }
                .navigationDestination(for: Car.self) { car in
                    Color(.systemRed)
                }

                Button {
                    showFullStack.toggle()

                    if (showFullStack) {
                        navigationPath = brands
                    } else {
                        navigationPath = [brands[0], brands[2], brands[1]]
                    }
                } label: {
                    Text("View All")
                }

            }
        }
    }

    func viewForBrand(_ brand: CarBrand) -> AnyView {
        switch brand.name {
            case "Ferrari":
                return AnyView(Color(.systemRed))
            case "Lamborghini":
                return AnyView(Color(.systemPurple))
            case "Mercedes":
                return AnyView(Color(.systemBlue))
            case "Aston Martin":
                return AnyView(Color(.systemOrange))
            default:
                return AnyView(Color(.systemGray))
        }
    }
}

/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */

#Preview {
    ContentView()
}
