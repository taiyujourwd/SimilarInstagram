//
//  Graphql.swift
//  SimilarInstagram
//
//  Created by Tai on 2022/11/15.
//

import Foundation

struct IGResponse: Codable {
    var graphql: Graphql
    struct Graphql: Codable {
        var user: User
        struct User: Codable {
            var biography: String //作者簡介
            var external_url: URL //白吉FB首頁
            var edge_followed_by: EdgeFollowedBy //粉絲追蹤數
            struct EdgeFollowedBy: Codable {
                var count: Int //粉絲追蹤數
            }
            var edge_follow: EdgeFollow
            struct EdgeFollow: Codable {
                var count: Int
            }
            var full_name: String //大頭照下方名字
            var category_name: String //名字下方類型
            var profile_pic_url: URL //個人檔案大頭照
            var username: String //最上方IG使用者名字
            var edge_felix_video_timeline: VideoDetail //影片貼文資訊
            struct VideoDetail: Codable {
                var count: Int //影片貼文數
                var page_info: VideoPageInfo //影片貼文是否有下一頁
                struct VideoPageInfo: Codable {
                    var has_next_page: Bool
                    var end_cursor: String
                }
                var edges: [VideoEdges]
                struct VideoEdges: Codable {
                    var node: VideoNode
                    struct VideoNode: Codable {
                        var video_url: URL //影片url
                        var edge_media_to_caption: EdgeMediaToCaption //影片貼文文字
                        struct EdgeMediaToCaption: Codable {
                            var edges: [VideoEdgeNode]
                            struct VideoEdgeNode: Codable {
                                var node: Text

                                struct Text: Codable {
                                    var text: String //影片貼文
                                }
                            }
                        }
                        var edge_media_to_comment: EdgeMediaToComment //影片貼文留言數
                        struct EdgeMediaToComment: Codable {
                            var count: Int //影片貼文留言數
                        }
                        var edge_liked_by: EdgeLikedBy
                        struct EdgeLikedBy: Codable {
                            var count: Int //影片貼文按讚數
                        }
                    }
                }
            }
            var edge_owner_to_timeline_media: PhotoDetail //照片貼文資訊
            struct PhotoDetail: Codable {
                var count: Int //照片貼文數
                var page_info: PhotoPageInfo //照片貼文是否有下一頁
                struct PhotoPageInfo: Codable {
                    var has_next_page: Bool
                    var end_cursor: String
                }
                var edges: [Edges]
                struct Edges: Codable {
                    var node: PhotoNode
                    struct PhotoNode: Codable {
                        var display_url: URL //照片貼文圖片
                        var edge_media_to_caption: EdgeMediaToCaption //照片貼文文字
                        struct EdgeMediaToCaption: Codable {
                            var edges: [PhotoEdges]
                            struct PhotoEdges: Codable {
                                var node: PhotoEdgesNode
                                struct PhotoEdgesNode: Codable {
                                    var text: String //照片貼文文字
                                }
                            }
                        }
                        var edge_media_to_comment: EdgeMediaToComment
                        struct EdgeMediaToComment: Codable {
                            var count: Int //圖片貼文留言數
                        }
                        var edge_liked_by: EdgeLikedBy
                        struct EdgeLikedBy: Codable {
                            var count: Int //圖片貼文安讚數
                        }
                    }
                }
            }

        }
    }
}
