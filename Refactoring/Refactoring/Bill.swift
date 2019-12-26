//
//  Bill.swift
//  Refactoring
//
//  Created by yrion on 2019/12/25.
//  Copyright © 2019 yrion. All rights reserved.
//

import Foundation

enum InvalidError: Error {
    case unknowType(type: String?)                   //选择无效
    case insufficientFunds(coinsNeeded: Int) //金额不足
    case outOfStock                             //缺货
}

func statement(invoice: Invoice, plays: Dictionary<String?, Play>) -> String {
    func playFor(aPerformance: Performance) -> Play? {
        return plays[aPerformance.playID]
    }

    func amountFor(aPerformance: Performance) throws -> Int {
        var result = 0;
        let audience = aPerformance.audience ?? 0
        switch playFor(aPerformance: aPerformance)?.type {
        case "tragedy":
            result = 40000
            if audience > 30 {
                result += 1000 * (audience - 30)
            }
        case "comedy":
            result = 30000
            if audience > 20 {
                result = 10000 + 500 * (audience - 20)
            }
            result += 300 * audience
        default:
            throw InvalidError.unknowType(type: playFor(aPerformance: aPerformance)!.type)
        }
        return result
    }
    
    func volumeCreditsFor(perf: Performance) -> Int {
        var result = 0
        result += max(perf.audience ?? 0, 0)
        if "comedy" == playFor(aPerformance: perf)?.type {
            result += lroundf(Float(perf.audience ?? 0) / 5)
        }
        return result
    }

    func totalVolumeCredits() -> Int {
        var result = 0
        for perf in invoice.performances ?? [] {
            result += volumeCreditsFor(perf: perf)
        }
        return result
    }

    func totalAmount() -> Int {
        var result = 0
        for perf in invoice.performances ?? [] {
            result += try! amountFor(aPerformance: perf)
        }
        return result
    }
    
    var result = "Statement for \(invoice.customer ?? "")\n"
    
    for perf in invoice.performances ?? [] {
        result += "\(playFor(aPerformance: perf)!.name ?? ""): \(try! amountFor(aPerformance: perf) / 100) (\(perf.audience ?? 0) seats)\n"
    }
    result += "Amount owed is \(totalAmount() / 100)\n"
    result += "You earned \(totalVolumeCredits()) credits\n"
    return result
}
