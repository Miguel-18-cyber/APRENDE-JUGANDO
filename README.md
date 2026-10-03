# Aprende jugando

App educativa hecha con Flutter para explorar retos de letras, números, memoria y colores. Las partidas guardan el progreso, la experiencia, los niveles y los logros en el dispositivo.

## Requisitos

- Flutter SDK compatible con Dart `^3.5.0`
- Android SDK para compilar la aplicación Android

## Ejecutar en desarrollo

```bash
flutter pub get
flutter run
```

## Versión web

La carpeta `web/` contiene el punto de entrada web de Flutter. Para generar los archivos estáticos:

```bash
flutter build web --release
```

El resultado queda en `build/web`. Los anuncios de AdMob solo se habilitan en Android; la versión web no solicita anuncios.

## AdMob para Android

- ID de aplicación: `ca-app-pub-3934791251127084~2918993093`
- Unidad de video bonificado: `ca-app-pub-3934791251127084/4064553809`
- Las compilaciones de desarrollo usan la unidad de prueba oficial de Google; el ID real se solicita en una compilación release.
- Las solicitudes se marcan como dirigidas a menores y limitan el contenido a clasificación G.
- El video es opcional y otorga 20 XP solo después de que AdMob confirme la recompensa. Se ofrece como máximo uno por sesión.
- El SDK Android 25.5 requiere Android API 24 como mínimo.

Antes de publicar, configura los mensajes de privacidad en AdMob según los países de distribución y declara anuncios y prácticas de datos en Play Console. Confirma también que el inventario servido cumple los requisitos de Familias, incluido el cierre del anuncio dentro del límite aplicable.

## Repositorio

Repositorio: [github.com/Miguel-18-ciber/APRENDE-JUGANDO](https://github.com/Miguel-18-ciber/APRENDE-JUGANDO)
