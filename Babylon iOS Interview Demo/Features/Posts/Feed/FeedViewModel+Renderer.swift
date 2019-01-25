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
import StyleSheets

typealias Context = FeedViewModel.Renderer.Context

extension FeedViewModel {
    
    struct Renderer {
        
        init() {}
        
        let (signal, observer) = Signal<Box<SectionId, RowId>, NoError>.pipe()

        func render(feed: Feed)  {
            
            let tappedClosure:((Int) -> Void) = { id in
                //TODO: FIX THIS
                print("id == \(id)")
            }
            
            let box = Box.empty
                |-+ Section(id: SectionId.noId)
                |---* self.makeRows(from: feed, using: tappedClosure)
            
            observer.send(value: box)
        }
        
        func makeRows(from posts: Feed, using didTapClosure: ((Int)-> Void)? = nil) -> [Node<RowId>] {
            
            guard posts.count > 0 else {
                return [RowId.noData <> PlaceholderComponent()]
            }
            
            return posts.map { post -> Node<RowId> in
                return RowId.post(post) <> PostComponent(id: post.id,
                                                         title: post.title,
                                                         body: post.body,
                                                         didTap: didTapClosure
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
        case feed(Feed)
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