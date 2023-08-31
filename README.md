# FARMAHELP - MÓVIL - WEB - DESARROLLADO FLUTTER

Aplicación usada para las personas dependientes o monitores dentro de cada farmacia, permite brindar información a cada cleinte, está compuesta por 2 módulos importantes:
    
* Actualización Datos Cliente
* Clientes y Productos

## Herramientas de instalación:
Este proyecto maneja las siguientes herramientas para el correcto funcionamiento:
- **[Flutter](https://docs.flutter.dev/get-started/install)**
- **[Android Studio](https://developer.android.com/studio)**

## Comandos para correr
Una vez instalado las herramientas correctas se deben ejecutar los siguientes comandos para su poder validar el funcionamiento:
<br>
Limpiamos los archivos precargados de configuración:
````
$ flutter clean
````

Instalamos las dependencias:
- En este caso también podemos hacerlo manualemnte a través del archivo <b>pubspec.yaml</b>
````
$ flutter pub get
````
También en el caso de ser necesario (<b>opcional</b>), ejecutar una búsqueda de actualizaciones de las dependencias:
````
$ flutter pub upgrade
````

## Cambiar variables de entorno
En la ruta raíz se ha generado un archivo llamado <b>env.example</b> con el fin de que sea un esquema tanto para el ambiente de producción y desarrollo, replicándolo y colonado los valores que son para las pruebas:
<br/>
Crear los archivos correspondientes para el funcionamiento, siguiendo el esquema de ejemplo:

* env.development
* env.production

## Probar el sistema
Una vez cumpliendo los pasos anteriormente mencionados, se prepara los siguientes entornos para prueba:

* Dispositivo móvil físico
* Dispositivo móvil virtual
* Dispositivo wev (Cualquier Cliente Web, ya se Google Chrome o Edge)

Una vez teniendo el dispositivo preparado, abrimos <b>Visual Studio Code</b> y seguimos los siguientes pasos:
<br/>

Seleccionar dispositivo:
1. Aplastamos la tecla <b>F1</b>.
2. Escribir <b>Flutter:Select Device</b>.
3. Escojemos el dispositivo anteriormente preparado.

<br/>
Correr la aplicación:

1. Dirigimos a la carpeta <b>lib</b>.
2. Escogemos el archibo <b>main.dart</b>
3. Revisamos el dispositivo preparado (opcional).
4. Aplastamos la tecla <b>F5</b>.

#### Repositorio 2023/08/07
* Ing. Jhostyn Benalcázar jhosga03052000@gmail.com +593 96 783 1156
