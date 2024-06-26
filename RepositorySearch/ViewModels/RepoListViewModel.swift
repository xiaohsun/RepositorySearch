//
//  RepoListViewModel.swift
//  RepositorySearch
//
//  Created by 徐柏勳 on 6/25/24.
//

import Foundation
import Combine

class RepoListViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    var repositories = CurrentValueSubject<[Item], Never>([])
    
    func fetchRepositories(query: String) {
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("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", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .map { $0.items }
            .catch { error -> Just<[Item]> in
                print("Decoding error: \(error)")
                return Just([])
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] repositories in
                self?.repositories.send(repositories)
            })
            .store(in: &subscriptions)
    }
}
