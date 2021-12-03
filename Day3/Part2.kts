import java.io.File
import java.io.InputStream

val inputStream = File("input.txt").inputStream()
val binaries = mutableListOf<String>()

inputStream.bufferedReader().useLines { lines -> lines.forEach { binaries.add(it) } }
var oxygen = binaries.toList()
var co2 = binaries.toList()

for (i in 0..(binaries[0].count() - 1)) {
    if (oxygen.count() > 1) {
        val zerosCount = oxygen.map { it[i] }.count { it == '0' }
        val onesCount = oxygen.map { it[i] }.count { it == '1' }

        if (zerosCount > onesCount) {
            oxygen = oxygen.filter { bin -> bin[i] == '0' }
        } else {
            oxygen = oxygen.filter { bin -> bin[i] == '1' }
        }
    }

    if (co2.count() > 1) {
        val zerosCount = co2.map { it[i] }.count { it == '0' }
        val onesCount = co2.map { it[i] }.count { it == '1' }

        if (zerosCount > onesCount) {
            co2 = co2.filter { bin -> bin[i] == '1' }
        } else {
            co2 = co2.filter { bin -> bin[i] == '0' }
        }
    }

    if (oxygen.count() == 1 && co2.count() == 1) break;
}


val result = Integer.parseInt(oxygen[0], 2) * Integer.parseInt(co2[0], 2)
println(result)