import java.io.File
import java.io.InputStream

val inputStream: InputStream = File("input.txt").inputStream()
val measurements = mutableListOf<Int>()

inputStream.bufferedReader().useLines { lines -> lines.forEach { measurements.add(it.toInt()) }}
val count = measurements
            .windowed(3, 1)
            .filter { it.size == 3 }
            .map { it.sum() }
            .zipWithNext { a, b -> b - a > 0 }
            .count { it }
println(count)
