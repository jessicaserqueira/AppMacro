import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> SwiftSyntax.ExprSyntax {
        
        var arguments = [ExprSyntax]()
        for argument in node.argumentList {
            arguments.append(argument.expression)
            if arguments.count == 3 { break }
        }
        
        guard node.argumentList.count >= 3 else {
            fatalError("Expected at least 3 arguments (DEBUG, BETA, RELEASE)")
        }
        
        let debug = arguments[0]
        let beta = arguments[1]
        let release = arguments[2]
        
        let code = """
                {
                #if DEBUG
                \(debug)()
                #elseif BETA
                \(beta)()
                #elseif RELEASE
                \(release)()
                #endif
                }()
                """
        
        return "\(raw: code)"
    }
}

@main
struct TestemacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
    ]
}
