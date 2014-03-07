# Cliente Objective-C para el API Rest de Jira de MediaNet Software
--------------


# ¿Qué?
Una librería en código abierto bajo licencia LGPLv3, que facilita el acceso a la API Rest del producto [Jira](https://www.atlassian.com/software/jira) de [Atlassian](https://www.atlassian.com/) para desarrollos de software sobre iOS o Mac OS.

# ¿Por qué?
Actualmente la plataforma Jira de Atlassian tiene un amplio uso en la gestión de de incidencias de software. Esta librería se ha realizado con el objetivo de dar un acceso fácil a su API Pública para aplicaciones basadas en sistemas Apple.

# ¿Cómo lo consigo?
Actualmente se puede descargar una versión estable desde repositorio en que se encuentra. El producto se genera en modo librería que puede ser añadida a tu proyecto actual.
Será añadido al gestor [CocoaPods](http://cocoapods.org/) en el futuro.

# ¿Cómo funciona?
El sistema centra su funcionamiento en la clase **MNSJiraRestClient**. Esta clase representa el acceso a la api a través de los clientes que implementan cada funcionalidad.

- **MNSIssueRestClient** - Acceso a la parte de gestión de issues. Permite crear y recuperar issues, recuperar la versión actual de Jira.  
- **MNSSearchRestClient** - Acceso a la búsqueda en Jira, haciendo uso de filtros. 
- **MNSComponentRestClient** - Acceso a los componentes de un proyecto. Permite recuperar los de un proyecto, crear, actualizar y eliminar.
- **MNSProjectRestClient** - Acceso a la parte de gestión de proyectos de la API. Permite recuperar los proyectos de una clave o los asocidados una cuenta.
- **MNSUserRestClient** - Acceso a la búsqueda de usuarios mediante email, nombre o url clave.
- **MNSVersionRestClient** - Acceso a la parte de gestión de versiones de proyecto. 

*MNSJiraRestObjectiveCClient* permite acceso anónimo y registrado.

NOTA: Actualmente utiliza la librería [AFNetWorking 2.0](http://afnetworking.com/) mediante CocoaPods. De modo que tras instalar será necesario ejecutar pod install en un terminal. 


# ¿Cómo lo pruebo?
Conjuntamente a la librería se incluyen una serie de tests automatizados para testear la funcionalidad de los clientes.


# ¿Quién lo ha hecho?
El departamento de movilidad de [MediaNet Software](http://www.medianet.es).