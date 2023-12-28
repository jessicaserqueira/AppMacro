@freestanding(expression)
public macro stringify(_ debug: () -> Void, _ release: () -> Void) = #externalMacro(
    module: "TestemacroMacros",
    type: "StringifyMacro"
)

@freestanding(expression)
public macro debugStringify<T>(_ value: T) -> T = #externalMacro(
    module: "TestemacroMacros",
    type: "DebugStringifyMacro"
)

@freestanding(expression)
public macro betaStringify<T>(_ value: T) -> T = #externalMacro(
    module: "TestemacroMacros",
    type: "BetaStringifyMacro"
   
)

@freestanding(expression)
public macro releaseStringify<T>(_ value: T) -> T = #externalMacro(
    module: "TestemacroMacros",
    type: "ReleaseStringifyMacro"
)
