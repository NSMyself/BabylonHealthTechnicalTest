//
//  FeedViewModel+Renderer.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 25/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Bento
import BentoKit
import ReactiveSwift
import UIKit

typealias Context = FeedViewModel.Renderer.Context

extension FeedViewModel {
    
    class Renderer {
        
        init() {
            monitorDismissal()
        }
        
        let (signal, observer) = Signal<Box<SectionId, RowId>, NoError>.pipe()
        let (tapSignal, tapObserver) = Signal<Action, NoError>.pipe()

        func render(feed: [Post])  {
            
            let box = Box.empty
                |-+ Section(id: SectionId.noId)
                |---* self.makeRows(from: feed)
            
            observer.send(value: box)
        }
        
        func makeRows(from posts: [Post]) -> [Node<RowId>] {
            
            guard posts.count > 0 else {
                return [RowId.noData <> PlaceholderComponent()]
            }
            
/*            return posts.map { post -> Node<RowId> in
                return RowId.post(post) <> Component.Description(
                    text: post.title,
                    accessoryIcon: nil,
                    didTap: { [weak self] in
                        self?.tapObserver.send(value: .didSelect(postId: post.id.rawValue))
                    },
                    styleSheet: Component.Description.StyleSheet()
                        .compose(\.backgroundColor, UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0))
                )*/
            
            return posts.map { post -> Node<RowId> in
                
                return RowId.post(post) <> PostComponent(
                    title: post.title,
                    body: "olarecas",
                    didTap: { [weak self] in
                        self?.tapObserver.send(value: .didSelect(postId: post.id.rawValue))
                    }
                )
            }
        }
        
        func render(placeholder: Context.Placeholder) {
            switch(placeholder) {
            case .loading:
                renderLoading()
            case .noData:
                renderNoData()
            }
        }
        
        private func renderLoading() {
            let box = Box<SectionId, RowId>.empty
                |-+ Section(id: SectionId.noId)
                |---+ Node(id: RowId.noData, component: PlaceholderComponent())
            
            observer.send(value: box)
        }
        
        private func renderNoData() {
            let box = Box<SectionId, RowId>.empty
                |-+ Section(id: SectionId.noId)
                |---+ Node(id: RowId.noData, component: PlaceholderComponent())
            
            observer.send(value: box)
        }
    }
}

extension FeedViewModel.Renderer {
    
    enum SectionId {
        case noId
    }
    
    enum RowId {
        case post(Post)
        case noData
        case loading
    }
    
    enum Context {
        case feed([Post])
        case placeholder(Placeholder)
        
        enum Placeholder {
            case loading
            case noData
        }
    }
}

extension FeedViewModel.Renderer.RowId: Hashable {
    static func == (lhs: FeedViewModel.Renderer.RowId, rhs: FeedViewModel.Renderer.RowId) -> Bool {
        switch(lhs, rhs) {
        case let (.post(lhsPost), .post(rhsPost)):
            return lhsPost == rhsPost
        default:
            return false
        }
    }
}

extension FeedViewModel.Renderer {
    
    // Used to detect if a user's dismissed a ReaderViewController
    // this is akin of saying that user just read a post and went back to the feed
    func monitorDismissal() {
        NotificationCenter
            .default
            .reactive
            .notifications(forName: .closePost)
            .observe { [tapObserver] _ in
                tapObserver.send(value: .didClosePost)
        }
    }
}
