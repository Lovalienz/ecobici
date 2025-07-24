# EcoBici Flutter App 🚲

Aplicación Flutter para consultar estaciones de bicicletas públicas utilizando el API de ecobici cdmx y mostrar su ubicación en el mapa mediante Google Maps.

## ✅ Características

- Consulta de estaciones disponibles.
- Búsqueda por nombre.
- Almacenamiento local de estaciones recientes.
- Visualización de estaciones en el mapa.
- Animaciones con Lottie.

## 🔧 Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/tu-usuario/eco_bici_app.git
cd eco_bici_app

    Instala dependencias:

flutter pub get

    Agrega tu clave de API de Google Maps:

    Android: en android/app/src/main/AndroidManifest.xml

<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="TU_API_KEY_AQUI"/>

    iOS: en ios/Runner/AppDelegate.swift

GMSServices.provideAPIKey("TU_API_KEY_AQUI")

O, si estás usando flutter_google_maps, también puedes configurarlo en el main.dart:

GoogleMapsFlutter.init(apiKey: "TU_API_KEY_AQUI");

    🔐 Recuerda no subir tu API Key a GitHub si el repositorio es público.

⚠️ Advertencias para iOS

    La versión actual aún no está completamente optimizada para iOS.

    Puede mostrar advertencias visuales menores (desbordes, ajustes de píxeles).

    La compatibilidad es funcional, pero se recomienda revisión adicional antes de usar en producción.

📦 Datos

Los datos de estaciones se consumen desde:

https://api.citybik.es/v2/networks/ecobici

🛠️ Tecnologías

    Flutter

    Hive para persistencia local

    Lottie para animaciones

    Google Maps Flutter

    GetIt para inyección de dependencias

🧑‍💻 Contribuciones

Si deseas colaborar, ¡eres bienvenido! Por favor, abre un issue o un pull request.
📝 Licencia

Este proyecto está bajo la licencia MIT.
