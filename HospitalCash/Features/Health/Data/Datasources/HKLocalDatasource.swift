//
//  HKLocalDatasource.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation
import HealthKit

protocol HKLocalDatasource {
    func requestReadAuthorisation(_ typesToRead: Set<HKObjectType>) async throws
    func readWeeklySteps(with anchorDate: Date?) async throws -> [HKStatistics]
    func readTodaysSteps() async throws -> HKStatistics
}

class HKLocalDataSourceImpl: HKLocalDatasource {
    
    var healthStore: HKHealthStore
    
    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }
    
    func requestReadAuthorisation(_ typesToRead: Set<HKObjectType>) async throws {
        guard HKHealthStore.isHealthDataAvailable() else {
            throw "Healthdata is not availabe on device"
        }
        let stepType = HKQuantityType(HKQuantityTypeIdentifier.stepCount)
        do {
            try await self.healthStore.requestAuthorization(toShare: [], read: [stepType])
        } catch {
            throw CommonError.accessDenied
        }
        
    }
    
    // see: https://developer.apple.com/documentation/healthkit/hkstatisticscollectionquerydescriptor
    func readWeeklySteps(with anchorDate: Date? = nil) async throws -> [HKStatistics] {
        let stepType = HKQuantityType(HKQuantityTypeIdentifier.stepCount)
        try await requestReadAuthorisation([stepType])
        let oneWeekAgo = DateUtils.onWeekAgoStartOfDay()
        let now = Date.now
        let dailyInterval = DateComponents(day: 1)
        let thisWeekPredicate = HKQuery.predicateForSamples(
            withStart: oneWeekAgo,
            end: now,
            options: .strictStartDate
        )
        let stepsThisWeek = HKSamplePredicate.quantitySample(
            type: stepType,
            predicate: thisWeekPredicate
        )
        
        let query = HKStatisticsCollectionQueryDescriptor(
            predicate: stepsThisWeek,
            options: .cumulativeSum,
            anchorDate: anchorDate ?? oneWeekAgo,
            intervalComponents: dailyInterval
        )
        let results = try await query.result(for: healthStore)
        return results.statistics();
    }
    
    // see: https://developer.apple.com/documentation/healthkit/hkstatisticsquerydescriptor
    func readTodaysSteps() async throws -> HKStatistics {
        let stepType = HKQuantityType(HKQuantityTypeIdentifier.stepCount)
        try await requestReadAuthorisation([stepType])
        
        let startOfDay = Calendar.current.startOfDay(for: Date.now)
        let now = Date.now
        let todayPredicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now
        )
        
        let stepsTodayPredicate = HKSamplePredicate.quantitySample(
            type: stepType,
            predicate: todayPredicate
        )
        let sumOfStepsQuery = HKStatisticsQueryDescriptor(
            predicate: stepsTodayPredicate,
            options: .cumulativeSum
        )
        
        let result = try await sumOfStepsQuery.result(for: healthStore);
        return result!;
    }
    
    
    
}

