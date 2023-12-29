import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(TestemacroMacros)
import TestemacroMacros

let testMacros: [String: Macro.Type] = [
    "stringify": StringifyMacro.self,
]
#endif

final class TestemacroTests: XCTestCase {
    func testMacro() throws {
        #if canImport(TestemacroMacros)
        assertMacroExpansion(
            """
            #stringify({
                print(debug)
            }, {
                print(beta)
            }, {
                print(release)
            })
            """,
            expandedSource: """
            {
                #if DEBUG
                {
                    print(debug)
                }()
                #elseif BETA
                {
                    print(beta)
                }()
                #elseif RELEASE
                {
                    print(release)
                }()
                #endif
            }()
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
