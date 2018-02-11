//
//  Result.swift
//  PSI App
//
//  Created by Gema Megantara on 11/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

enum Result<D, E> where E: Error {
    case success(payload: D)
    case failure(E?)
}

enum EmptyResult<E> where E: Error {
    case success
    case failure(E?)
}
