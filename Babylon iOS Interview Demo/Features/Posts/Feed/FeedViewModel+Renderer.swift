//
//  FeedViewModel+Renderer.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 25/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Bento
import ReactiveSwift

typealias Context = FeedViewModel.Renderer.Context

extension FeedViewModel {
    
    struct Renderer {
        
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

        func render(feed: Feed) -> Box<SectionId, RowId> {
            return Box.empty
                |-+ Section(id: SectionId.noId)
                |---* self.makeRows(from: feed)
        }
        
        func makeRows(from posts: Feed) -> [Node<RowId>] {
            
            guard posts.count > 0 else {
                return [RowId.noData <> PlaceholderComponent()]
            }
            
            return posts.map { post -> Node<RowId> in
                return RowId.post(post) <> PostComponent(id: post.id,
                                                         title: post.title,
                                                         description: post.body
                )
            }
        }
        
        func render(placeholder: Context.Placeholder) -> Box<SectionId, RowId> {
            switch(placeholder) {
            case .loading:
                return renderLoading()
            case .noData:
                return renderNoData()
            }
        }
        
        private func renderLoading() -> Box<SectionId, RowId> {
            return Box<SectionId, RowId>.empty
                |-+ Section(id: SectionId.noId)
                |---+ Node(id: RowId.noData, component: PlaceholderComponent())
        }
        
        private func renderNoData() -> Box<SectionId, RowId> {
            return Box<SectionId, RowId>.empty
                |-+ Section(id: SectionId.noId)
                |---+ Node(id: RowId.noData, component: PlaceholderComponent())
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
