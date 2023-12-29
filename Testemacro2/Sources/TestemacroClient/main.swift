import Testemacro

let debug: Int = 25
let beta: Int = 60
let release: Int = 50

#stringify({
    print(debug)
}, {
    print(beta)
}, {
    print(release)
})
