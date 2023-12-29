@freestanding(expression)
public macro stringify(_ debug: () -> Void, _ beta: () -> Void, _ release: () -> Void) = #externalMacro(
    module: "TestemacroMacros",
    type: "StringifyMacro"
)
