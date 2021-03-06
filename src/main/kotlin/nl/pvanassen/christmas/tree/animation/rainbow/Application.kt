package nl.pvanassen.christmas.tree.animation.rainbow

import io.micronaut.runtime.Micronaut

object Application {

    @JvmStatic
    fun main(args: Array<String>) {
        Micronaut.build()
                .packages("nl.pvanassen.christmas.tree.animation.rainbow.animation")
                .mainClass(Application.javaClass)
                .start()
    }
}
