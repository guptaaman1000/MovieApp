// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.6.0


import SwiftyMocky
import XCTest
import Combine
import Core
@testable import MovieApp


// MARK: - AppRouterType

open class AppRouterTypeMock: AppRouterType, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func displayMovieOptionsView() -> MovieOptionsView {
        addInvocation(.m_displayMovieOptionsView)
		let perform = methodPerformValue(.m_displayMovieOptionsView) as? () -> Void
		perform?()
		var __value: MovieOptionsView
		do {
		    __value = try methodReturnValue(.m_displayMovieOptionsView).casted()
		} catch {
			onFatalFailure("Stub return value not specified for displayMovieOptionsView(). Use given")
			Failure("Stub return value not specified for displayMovieOptionsView(). Use given")
		}
		return __value
    }

    open func displayMovieList(of type: MovieType) -> MovieListView {
        addInvocation(.m_displayMovieList__of_type(Parameter<MovieType>.value(`type`)))
		let perform = methodPerformValue(.m_displayMovieList__of_type(Parameter<MovieType>.value(`type`))) as? (MovieType) -> Void
		perform?(`type`)
		var __value: MovieListView
		do {
		    __value = try methodReturnValue(.m_displayMovieList__of_type(Parameter<MovieType>.value(`type`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for displayMovieList(of type: MovieType). Use given")
			Failure("Stub return value not specified for displayMovieList(of type: MovieType). Use given")
		}
		return __value
    }

    open func displayMovieDetail(metaData: MovieMetaData, type: MovieType) -> MovieDetailView {
        addInvocation(.m_displayMovieDetail__metaData_metaDatatype_type(Parameter<MovieMetaData>.value(`metaData`), Parameter<MovieType>.value(`type`)))
		let perform = methodPerformValue(.m_displayMovieDetail__metaData_metaDatatype_type(Parameter<MovieMetaData>.value(`metaData`), Parameter<MovieType>.value(`type`))) as? (MovieMetaData, MovieType) -> Void
		perform?(`metaData`, `type`)
		var __value: MovieDetailView
		do {
		    __value = try methodReturnValue(.m_displayMovieDetail__metaData_metaDatatype_type(Parameter<MovieMetaData>.value(`metaData`), Parameter<MovieType>.value(`type`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for displayMovieDetail(metaData: MovieMetaData, type: MovieType). Use given")
			Failure("Stub return value not specified for displayMovieDetail(metaData: MovieMetaData, type: MovieType). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_displayMovieOptionsView
        case m_displayMovieList__of_type(Parameter<MovieType>)
        case m_displayMovieDetail__metaData_metaDatatype_type(Parameter<MovieMetaData>, Parameter<MovieType>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_displayMovieOptionsView, .m_displayMovieOptionsView): return .match

            case (.m_displayMovieList__of_type(let lhsType), .m_displayMovieList__of_type(let rhsType)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "of type"))
				return Matcher.ComparisonResult(results)

            case (.m_displayMovieDetail__metaData_metaDatatype_type(let lhsMetadata, let lhsType), .m_displayMovieDetail__metaData_metaDatatype_type(let rhsMetadata, let rhsType)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMetadata, rhs: rhsMetadata, with: matcher), lhsMetadata, rhsMetadata, "metaData"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher), lhsType, rhsType, "type"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_displayMovieOptionsView: return 0
            case let .m_displayMovieList__of_type(p0): return p0.intValue
            case let .m_displayMovieDetail__metaData_metaDatatype_type(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_displayMovieOptionsView: return ".displayMovieOptionsView()"
            case .m_displayMovieList__of_type: return ".displayMovieList(of:)"
            case .m_displayMovieDetail__metaData_metaDatatype_type: return ".displayMovieDetail(metaData:type:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func displayMovieOptionsView(willReturn: MovieOptionsView...) -> MethodStub {
            return Given(method: .m_displayMovieOptionsView, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func displayMovieList(of type: Parameter<MovieType>, willReturn: MovieListView...) -> MethodStub {
            return Given(method: .m_displayMovieList__of_type(`type`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func displayMovieDetail(metaData: Parameter<MovieMetaData>, type: Parameter<MovieType>, willReturn: MovieDetailView...) -> MethodStub {
            return Given(method: .m_displayMovieDetail__metaData_metaDatatype_type(`metaData`, `type`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func displayMovieOptionsView(willProduce: (Stubber<MovieOptionsView>) -> Void) -> MethodStub {
            let willReturn: [MovieOptionsView] = []
			let given: Given = { return Given(method: .m_displayMovieOptionsView, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (MovieOptionsView).self)
			willProduce(stubber)
			return given
        }
        public static func displayMovieList(of type: Parameter<MovieType>, willProduce: (Stubber<MovieListView>) -> Void) -> MethodStub {
            let willReturn: [MovieListView] = []
			let given: Given = { return Given(method: .m_displayMovieList__of_type(`type`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (MovieListView).self)
			willProduce(stubber)
			return given
        }
        public static func displayMovieDetail(metaData: Parameter<MovieMetaData>, type: Parameter<MovieType>, willProduce: (Stubber<MovieDetailView>) -> Void) -> MethodStub {
            let willReturn: [MovieDetailView] = []
			let given: Given = { return Given(method: .m_displayMovieDetail__metaData_metaDatatype_type(`metaData`, `type`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (MovieDetailView).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func displayMovieOptionsView() -> Verify { return Verify(method: .m_displayMovieOptionsView)}
        public static func displayMovieList(of type: Parameter<MovieType>) -> Verify { return Verify(method: .m_displayMovieList__of_type(`type`))}
        public static func displayMovieDetail(metaData: Parameter<MovieMetaData>, type: Parameter<MovieType>) -> Verify { return Verify(method: .m_displayMovieDetail__metaData_metaDatatype_type(`metaData`, `type`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func displayMovieOptionsView(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_displayMovieOptionsView, performs: perform)
        }
        public static func displayMovieList(of type: Parameter<MovieType>, perform: @escaping (MovieType) -> Void) -> Perform {
            return Perform(method: .m_displayMovieList__of_type(`type`), performs: perform)
        }
        public static func displayMovieDetail(metaData: Parameter<MovieMetaData>, type: Parameter<MovieType>, perform: @escaping (MovieMetaData, MovieType) -> Void) -> Perform {
            return Perform(method: .m_displayMovieDetail__metaData_metaDatatype_type(`metaData`, `type`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - FavouriteInteractorType

open class FavouriteInteractorTypeMock: FavouriteInteractorType, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func handleFavourite(detail: MovieDetail, metaData: MovieMetaData) {
        addInvocation(.m_handleFavourite__detail_detailmetaData_metaData(Parameter<MovieDetail>.value(`detail`), Parameter<MovieMetaData>.value(`metaData`)))
		let perform = methodPerformValue(.m_handleFavourite__detail_detailmetaData_metaData(Parameter<MovieDetail>.value(`detail`), Parameter<MovieMetaData>.value(`metaData`))) as? (MovieDetail, MovieMetaData) -> Void
		perform?(`detail`, `metaData`)
    }

    open func updateFavourite(detail: MovieDetail) -> MovieDetail {
        addInvocation(.m_updateFavourite__detail_detail(Parameter<MovieDetail>.value(`detail`)))
		let perform = methodPerformValue(.m_updateFavourite__detail_detail(Parameter<MovieDetail>.value(`detail`))) as? (MovieDetail) -> Void
		perform?(`detail`)
		var __value: MovieDetail
		do {
		    __value = try methodReturnValue(.m_updateFavourite__detail_detail(Parameter<MovieDetail>.value(`detail`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for updateFavourite(detail: MovieDetail). Use given")
			Failure("Stub return value not specified for updateFavourite(detail: MovieDetail). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_handleFavourite__detail_detailmetaData_metaData(Parameter<MovieDetail>, Parameter<MovieMetaData>)
        case m_updateFavourite__detail_detail(Parameter<MovieDetail>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_handleFavourite__detail_detailmetaData_metaData(let lhsDetail, let lhsMetadata), .m_handleFavourite__detail_detailmetaData_metaData(let rhsDetail, let rhsMetadata)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDetail, rhs: rhsDetail, with: matcher), lhsDetail, rhsDetail, "detail"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMetadata, rhs: rhsMetadata, with: matcher), lhsMetadata, rhsMetadata, "metaData"))
				return Matcher.ComparisonResult(results)

            case (.m_updateFavourite__detail_detail(let lhsDetail), .m_updateFavourite__detail_detail(let rhsDetail)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDetail, rhs: rhsDetail, with: matcher), lhsDetail, rhsDetail, "detail"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_handleFavourite__detail_detailmetaData_metaData(p0, p1): return p0.intValue + p1.intValue
            case let .m_updateFavourite__detail_detail(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_handleFavourite__detail_detailmetaData_metaData: return ".handleFavourite(detail:metaData:)"
            case .m_updateFavourite__detail_detail: return ".updateFavourite(detail:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func updateFavourite(detail: Parameter<MovieDetail>, willReturn: MovieDetail...) -> MethodStub {
            return Given(method: .m_updateFavourite__detail_detail(`detail`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func updateFavourite(detail: Parameter<MovieDetail>, willProduce: (Stubber<MovieDetail>) -> Void) -> MethodStub {
            let willReturn: [MovieDetail] = []
			let given: Given = { return Given(method: .m_updateFavourite__detail_detail(`detail`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (MovieDetail).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func handleFavourite(detail: Parameter<MovieDetail>, metaData: Parameter<MovieMetaData>) -> Verify { return Verify(method: .m_handleFavourite__detail_detailmetaData_metaData(`detail`, `metaData`))}
        public static func updateFavourite(detail: Parameter<MovieDetail>) -> Verify { return Verify(method: .m_updateFavourite__detail_detail(`detail`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func handleFavourite(detail: Parameter<MovieDetail>, metaData: Parameter<MovieMetaData>, perform: @escaping (MovieDetail, MovieMetaData) -> Void) -> Perform {
            return Perform(method: .m_handleFavourite__detail_detailmetaData_metaData(`detail`, `metaData`), performs: perform)
        }
        public static func updateFavourite(detail: Parameter<MovieDetail>, perform: @escaping (MovieDetail) -> Void) -> Perform {
            return Perform(method: .m_updateFavourite__detail_detail(`detail`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - MovieInteractorType

open class MovieInteractorTypeMock: MovieInteractorType, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, NetworkError> {
        addInvocation(.m_getMovieList__page_page(Parameter<Int>.value(`page`)))
		let perform = methodPerformValue(.m_getMovieList__page_page(Parameter<Int>.value(`page`))) as? (Int) -> Void
		perform?(`page`)
		var __value: AnyPublisher<MovieListResponse, NetworkError>
		do {
		    __value = try methodReturnValue(.m_getMovieList__page_page(Parameter<Int>.value(`page`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getMovieList(page: Int). Use given")
			Failure("Stub return value not specified for getMovieList(page: Int). Use given")
		}
		return __value
    }

    open func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, NetworkError> {
        addInvocation(.m_getMovieDetail__id_id(Parameter<Int>.value(`id`)))
		let perform = methodPerformValue(.m_getMovieDetail__id_id(Parameter<Int>.value(`id`))) as? (Int) -> Void
		perform?(`id`)
		var __value: AnyPublisher<MovieDetail, NetworkError>
		do {
		    __value = try methodReturnValue(.m_getMovieDetail__id_id(Parameter<Int>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getMovieDetail(id: Int). Use given")
			Failure("Stub return value not specified for getMovieDetail(id: Int). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getMovieList__page_page(Parameter<Int>)
        case m_getMovieDetail__id_id(Parameter<Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getMovieList__page_page(let lhsPage), .m_getMovieList__page_page(let rhsPage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher), lhsPage, rhsPage, "page"))
				return Matcher.ComparisonResult(results)

            case (.m_getMovieDetail__id_id(let lhsId), .m_getMovieDetail__id_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getMovieList__page_page(p0): return p0.intValue
            case let .m_getMovieDetail__id_id(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getMovieList__page_page: return ".getMovieList(page:)"
            case .m_getMovieDetail__id_id: return ".getMovieDetail(id:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getMovieList(page: Parameter<Int>, willReturn: AnyPublisher<MovieListResponse, NetworkError>...) -> MethodStub {
            return Given(method: .m_getMovieList__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getMovieDetail(id: Parameter<Int>, willReturn: AnyPublisher<MovieDetail, NetworkError>...) -> MethodStub {
            return Given(method: .m_getMovieDetail__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getMovieList(page: Parameter<Int>, willProduce: (Stubber<AnyPublisher<MovieListResponse, NetworkError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<MovieListResponse, NetworkError>] = []
			let given: Given = { return Given(method: .m_getMovieList__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<MovieListResponse, NetworkError>).self)
			willProduce(stubber)
			return given
        }
        public static func getMovieDetail(id: Parameter<Int>, willProduce: (Stubber<AnyPublisher<MovieDetail, NetworkError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<MovieDetail, NetworkError>] = []
			let given: Given = { return Given(method: .m_getMovieDetail__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<MovieDetail, NetworkError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getMovieList(page: Parameter<Int>) -> Verify { return Verify(method: .m_getMovieList__page_page(`page`))}
        public static func getMovieDetail(id: Parameter<Int>) -> Verify { return Verify(method: .m_getMovieDetail__id_id(`id`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getMovieList(page: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_getMovieList__page_page(`page`), performs: perform)
        }
        public static func getMovieDetail(id: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_getMovieDetail__id_id(`id`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

