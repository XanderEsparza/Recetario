import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:recetario/ui/pantalla_busqueda.dart';
import 'package:recetario/ui/pantalla_perfil.dart';
import './pantalla_misrecetas.dart';
import './pantalla_recetas.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    // Pantallas para cada pestaña
    List<Widget> _buildScreens() {
      return [
        PantallaRecetas(),
        PantallaBusqueda(),
        PantallaMisRecetas(),
        PantallaPerfil()
      ];
    }

    // Íconos y etiquetas del Navbar
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: "Inicio",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          title: "Buscar",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.book),
          title: "Mis Recetas",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: "Perfil",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
