object luke {
  var cantidadViajes = 0
  var recuerdo = null
  var vehiculo = alambiqueVeloz
  
  method cantidadViajes() = cantidadViajes
  
  method viajar(lugar) {
    if (lugar.puedeLlegar(vehiculo)) {
      cantidadViajes += 1
      recuerdo = lugar.recuerdoTipico()
      vehiculo.desgaste()
    }
  }
  
  method recuerdo() = recuerdo
  
  method vehiculo(nuevo) {
    vehiculo = nuevo
  }
}

object paris {
  method recuerdoTipico() = "Llavero Torre Eiffel"
  
  method puedeLlegar(movil) = movil.puedeFuncionar()
}

object buenosAires {
  method recuerdoTipico() = "Mate"
  
  method puedeLlegar(auto) = auto.rapido()
}

object bagdad {
  var recuerdo = "bidon de petroleo"
  
  method recuerdoTipico() = recuerdo
  
  method recuerdo(nuevo) {
    recuerdo = nuevo
  }
  
  method puedeLlegar(cualquierCosa) = true
}

object lasVegas {
  var homenaje = paris
  
  method homenaje(lugar) {
    homenaje = lugar
  }
  
  method recuerdoTipico() = homenaje.recuerdoTipico()
  
  method puedeLlegar(vehiculo) = homenaje.puedeLlegar(vehiculo)
}

object hurlingham {
  method puedeLlegar(
    vehiculo
  ) = (vehiculo.puedeFuncionar() and vehiculo.rapido()) and vehiculo.patenteValida()
  
  method recuerdoTipico() = "sticker de la Unahur"
}

object antigualla {
  var gangsters = 7
  
  method puedeFuncionar() = gangsters.even()
  
  method rapido() = gangsters > 6
  
  method desgaste() {
    gangsters -= 1
  }
  
  method patenteValida() = chatarra.rapido()
}

object alambiqueVeloz {
  var rapido = true
  var combustible = 20
  const consumoPorViaje = 10
  var patente = "AB123JK"
  
  method puedeFuncionar() = combustible >= consumoPorViaje
  
  method desgaste() {
    combustible -= consumoPorViaje
  }
  
  method rapido() = rapido
  
  method patenteValida() = patente.head() == "A"
}

object chatarra {
  var cañones = 10
  var municiones = "ACME"
  
  method puedeFuncionar() = (municiones == "ACME") and cañones.between(6, 12)
  
  method rapido() = municiones.size() < cañones
  
  method desgaste() {
    cañones = (cañones / 2).roundUp(0)
    if (cañones < 5) {
      municiones += " Obsoleto"
    }
  }
  
  method patenteValida() = municiones.take(4) == "ACME"
  
  method cañones() = cañones
}

object convertible {
  var convertido = antigualla
  
  method puedeFuncionar() = convertido.puedeFuncionar()
  
  method rapido() = convertido.rapido()
  
  method desgaste() {
    convertido.desgaste()
  }
  
  method convertir(vehiculo) {
    convertido = vehiculo
  }
  
  method patenteValida() = convertido.patenteValida()
}

object moto {
  method rapido() = true
  
  method puedeFuncionar() = not moto.rapido()
  
  method desgaste() {
    
  }
  
  method patenteValida() = false
} //autos locos

object carrera {
  var property vehiculos = []
  var property ciudad = paris
  var property empezo = false
  
  method empezar() {
    empezo = true
  }
  
  method llegarACiudad() {
    vehiculos.forEach({ v => v.desgaste() })
  }
  
  method ganadorCarrera() = vehiculos.min({ v => v.velocidad() })
}

object centroInscripcion {
  var vehiculosAnotados = []
  var vehiculosRechazados = []
  var todosLosVehiculos = []
  
  method puedeCompetir_en_(vehiculo, lugar) = lugar.puedeLlegar(vehiculo)
  
  method inscribirVehiculo(vehiculo) {
    if (self.puedeCompetir_en_(vehiculo, carrera.ciudad()))
      vehiculosAnotados.add(vehiculo)
    else vehiculosRechazados.add(vehiculo)
  }
  
  method replanificacionDeCiudad(nuevaCiudad) {
    if (!carrera.empezo()) {
      carrera.ciudad(nuevaCiudad)
      todosLosVehiculos = vehiculosAnotados + vehiculosRechazados
      vehiculosAnotados = todosLosVehiculos.filter(
        { v => self.puedeCompetir_en_(v, nuevaCiudad) }
      )
      vehiculosRechazados = todosLosVehiculos.filter(
        { v => not self.puedeCompetir_en_(v, nuevaCiudad) }
      )
    }
  }
  
  method prepararCarrera() {
    carrera.vehiculos(vehiculosAnotados)
  }
} //nuevos vehiculos

object antiguallaBlindada {
  const gansters = ["a", "b", "c", "d", "f", "g", "h"]
  
  method subirGanster(g) {
    gansters.add(g)
  }
  
  method bajarGanster(g) {
    gansters.remove(g)
  }
  
  method velocidad() = gansters.sum({ g => g.length() })
}

object pierreYPatan {
  method velocidad() = 100000
}

object profesorLocovich {
  const vehiculosQuePuedeCambiar = [chatarra, antigualla, moto]
  var vehiculoActual = alambiqueVeloz
  
  method puedeCambiar() = not carrera.empezo()
  
  method cambiarVehiculo() {
    if (self.puedeCambiar() and (not vehiculosQuePuedeCambiar.isEmpty())) {
      vehiculoActual = vehiculosQuePuedeCambiar[0]
      vehiculosQuePuedeCambiar.remove(0)
    }
  }
}