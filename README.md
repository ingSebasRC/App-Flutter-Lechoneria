# 🐷 Lechonería Premium App & CRM

¡Bienvenido a **Lechonería Premium**! Una solución integral de delivery y gestión de ventas diseñada para negocios gastronómicos. Este proyecto ha sido desarrollado como una pieza de portafolio profesional, demostrando habilidades avanzadas en el desarrollo de aplicaciones móviles con **Flutter** y gestión de datos local con **SQLite**.

---

## 🚀 Características Principales

### 🛒 Experiencia del Cliente (Frontend)
- **Catálogo Categorizado**: Interfaz moderna con navegación por pestañas (Lechona, Bebidas) para una mejor experiencia de usuario.
- **Sistema de Carrito Avanzado**: Gestión dinámica de cantidades, cálculo automático de subtotales y total.
- **Flujo de Checkout Optimizado**: Formulario de entrega intuitivo y pantalla de éxito animada con resumen de pedido.
- **Diseño Responsive & Animado**: Uso de micro-animaciones con `flutter_animate` para una sensación fluida y premium.

### 📊 Panel Administrativo (CRM & Dashboard)
- **Dashboard Analítico**: Visualización en tiempo real de:
  - **Ingresos Totales**: Cálculo dinámico de ventas cerradas.
  - **Pedidos Activos**: Contador de entregas pendientes.
  - **Producto Estrella**: Algoritmo que detecta el producto más vendido automáticamente.
- **Gestión de Flujo de Trabajo (Workflow)**: Control total sobre el estado del pedido: `Pendiente` ➔ `En Preparación` ➔ `Enviado` ➔ `Entregado`.
- **Filtrado por Pestañas**: Organización eficiente de pedidos según su estado actual.
- **Seguridad**: Acceso protegido para administradores mediante login.

---

## 🛠️ Stack Tecnológico

- **Framework**: [Flutter](https://flutter.dev/) (v3.x+)
- **Lenguaje**: Dart
- **Base de Datos**: [SQFlite](https://pub.dev/packages/sqflite) (SQLite local)
- **Animaciones**: [Flutter Animate](https://pub.dev/packages/flutter_animate)
- **Fuentes**: Google Fonts (Montserrat & Inter)
- **Arquitectura**: Patrón de Servicios y Singleton para gestión de estado del carrito.

---

## 📦 Instalación y Configuración

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/tu-usuario/App-Flutter-Lechoneria.git
   ```

2. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación:**
   ```bash
   flutter run
   ```

> **Nota**: Asegúrate de tener configurado tu entorno de desarrollo para Flutter y un emulador (Android/iOS) o dispositivo físico conectado.

---

## 🔑 Credenciales de Admin
- **Usuario**: `admin`
- **Contraseña**: `123`

---

## 📐 Estructura del Proyecto

```text
lib/
├── db/             # Gestión de SQLite (versión 4 con migraciones)
├── modelos/        # Modelos de datos (Pedido, Plato, Usuario, ItemCarrito)
├── pantallas/      # Vistas principales (Catálogo, CRM, Carrito, etc.)
├── servicios/      # Lógica de negocio (Carrito, Analítica)
└── widgets/        # Componentes UI reutilizables
```

---

## 🛡️ Roadmap de Futuras Mejoras
- [ ] Integración con Firebase para notificaciones en tiempo real.
- [ ] Implementación de pasarela de pagos (Stripe/PayU).
- [ ] Generación de reportes PDF de ventas mensuales.
- [ ] Geolocalización para rastreo de pedidos en mapa.

---

## 👨‍💻 Autor
**Ing. Sebas** - [Tu LinkedIn](https://linkedin.com/in/tu-link)

---

*Este proyecto es de código abierto y fue creado con fines educativos y de portafolio profesional.*
