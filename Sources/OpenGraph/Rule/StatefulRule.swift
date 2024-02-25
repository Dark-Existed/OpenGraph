//
//  StatefulRule.swift
//  OpenGraph
//
//  Updated by Kyle on 2024/2/25.
//  Lastest Version: iOS 15.5
//  Status: Complete

import _OpenGraph

public protocol StatefulRule: _AttributeBody {
    associatedtype Value
    static var initialValue: Value? { get }
    func updateValue()
}

// MARK: - StatefulRule Protocol default implementation

extension StatefulRule {
    public static var initialValue: Value? { nil }

    public static func _update(_ pointer: UnsafeMutableRawPointer, attribute _: OGAttribute) {
        pointer.assumingMemoryBound(to: Self.self)
            .pointee
            .updateValue()
    }

    public static func _updateDefault(_: UnsafeMutableRawPointer) {
        guard let initialValue else {
            return
        }
        withUnsafePointer(to: initialValue) { valuePointer in
            OGGraphSetOutputValue(valuePointer)
        }
    }
}

// MARK: - StatefulRule extension

extension StatefulRule {
    public var attribute: Attribute<Value> {
        Attribute<Value>(identifier: OGAttribute.current!)
    }

    public var context: RuleContext<Value> {
        RuleContext<Value>(attribute: attribute)
    }
    
    public var value: Value {
        unsafeAddress { OGGraphGetOutputValue()! }
        nonmutating set { context.value = newValue }
    }
    
    public var hasValue: Bool { context.hasValue }
}
