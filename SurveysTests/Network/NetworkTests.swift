//
//  NetworkTests.swift
//  SurveysTests
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Quick
import Nimble
import Moya
import Result
@testable import Surveys

final class NetworkTests: QuickSpec {

    override func spec() {
        super.spec()
        var provider: MoyaProvider<NimbleTarget>!
        describe("A Moya Provider with NimbleTarget") {
            context("when the response is failure") {
                beforeEach {
                    provider = MoyaProvider<NimbleTarget>(endpointClosure: NetworkTests.failureEndpointClosure,
                                                          stubClosure: MoyaProvider.immediatelyStub)
                }
                it("can not get access token") {
                    waitUntil(timeout: Configuration.timeout, action: { done in
                        provider.request(.credentials, completion: { result in
                            if case Result<Moya.Response, MoyaError>.failure(let error) = result {
                                expect(error).notTo(beNil())
                            }
                            done()
                        })
                    })
                }

                it("can not get surveys") {
                    waitUntil(timeout: Configuration.timeout, action: { done in
                        provider.request(.surveys(page: 0, perPage: 10), completion: { result in
                            if case Result<Moya.Response, MoyaError>.failure(let error) = result {
                                expect(error).notTo(beNil())
                            }
                            done()
                        })
                    })
                }
            }

            context("when the response is success") {
                beforeEach {
                    provider = MoyaProvider<NimbleTarget>(endpointClosure: NetworkTests.successEndpointClosure,
                                                          requestClosure: MoyaProvider<NimbleTarget>.tokenRequestMapping,
                                                          stubClosure: MoyaProvider.immediatelyStub)
                }

                it("has access token as expected") {
                    waitUntil(timeout: Configuration.timeout, action: { done in
                        provider.request(.credentials, completion: { result in
                            if case Result<Moya.Response, MoyaError>.success(let value) = result {
                                let token = try? JSONDecoder().decode(Token.self, from: value.data)
                                expect(token).notTo(beNil())
                            }
                            done()
                        })
                    })
                }

                it("has value for surveys as expected") {
                    waitUntil(timeout: Configuration.timeout, action: { done in
                        provider.request(.surveys(page: 0, perPage: 10), completion: { result in
                            if case Result<Moya.Response, MoyaError>.success(let value) = result {
                                let surveys = try? JSONDecoder().decode([Survey].self, from: value.data)
                                expect(surveys).notTo(beNil())
                                expect(surveys?.count) == 8
                            }
                            done()
                        })
                    })
                }
            }
        }
    }

    class func successEndpointClosure(_ target: NimbleTarget) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }

    private class func failureEndpointClosure(_ target: NimbleTarget) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkError(NetworkError.requestMapping as NSError) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
}

// MARK: - SampleData For Testing
extension NimbleTarget {
    var sampleData: Data {
        switch self {
        case .credentials:
            if let data = try? Data(forResource: "Token-Success",
                            withExtension: "json",
                            bundle: Bundle(for: NetworkTests.self)) {
                return data
            }
        case .surveys:
            if let data = try? Data(forResource: "Surveys-Success",
                               withExtension: "json",
                               bundle: Bundle(for: NetworkTests.self)) {
                return data
            }
        }
        return Data()
    }
}

// MARK: - Configuration
extension NetworkTests {
    enum Configuration {
        static let timeout: TimeInterval = 5
        static let firstIndexPath: IndexPath = IndexPath(item: 0, section: 0)
        static let sixthIndexPath: IndexPath = IndexPath(item: 6, section: 0)
    }
}
