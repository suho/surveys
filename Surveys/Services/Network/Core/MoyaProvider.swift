//
//  MoyaProvider.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation
import Moya

extension MoyaProvider {
    final class func tokenRequestMapping(for endpoint: Endpoint, closure: @escaping RequestResultClosure) {
        do {
            let urlRequest = try endpoint.urlRequest()
            prepare(urlRequest, completion: closure)
        } catch MoyaError.requestMapping(let url) {
            closure(.failure(MoyaError.requestMapping(url)))
        } catch MoyaError.parameterEncoding(let error) {
            closure(.failure(MoyaError.parameterEncoding(error)))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }

    class func prepare(_ request: URLRequest, completion: @escaping RequestResultClosure) {
        var request = request
        if let token = Token.current, token.isValid() {
            request.update(token: token)
            completion(.success(request))
        } else {
            MoyaProvider<NimbleTarget>().request(.credentials) { (result) in
                switch result {
                case .success(let value):
                    guard let token: Token = try? JSONDecoder().decode(Token.self, from: value.data) else {
                        completion(.failure(MoyaError.requestMapping(request.url?.absoluteString ?? "")))
                        return
                    }
                    Token.current = token
                    request.update(token: token)
                    completion(.success(request))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
