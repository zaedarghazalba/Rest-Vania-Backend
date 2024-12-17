import 'package:mobile_vania/app/http/controllers/auth_controller.dart';
import 'package:mobile_vania/app/http/controllers/order_controller.dart';
import 'package:mobile_vania/app/http/controllers/order_item_controller.dart';
import 'package:mobile_vania/app/http/controllers/product_controller.dart';
import 'package:mobile_vania/app/http/controllers/product_note_controller.dart';
import 'package:mobile_vania/app/http/controllers/vendor_controller.dart';
import 'package:mobile_vania/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';
import 'package:mobile_vania/app/http/controllers/customer_controller.dart'; // Import CustomerController

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.group(() {
      Router.post('register', authController.register);
      Router.post('login', authController.login);
    }, prefix: 'auth');

    // Customer Routes
    Router.group(() {
    Router.get("/customers", customerController.index);
    Router.post("/customers", customerController.store);
    Router.get("/customers/{id}", customerController.show);
    Router.put("/customers/{id}", customerController.update);
    Router.delete("/customers/{id}", customerController.destroy);


    //venodrs route
    Router.resource("vendor", vendorController);
    
    Router.resource("product", productController);

    Router.resource("notesProduct", productNoteController);

    Router.resource("orders", orderController);
    Router.delete("/orders/{id}", orderController.destroy);
    Router.get("/orders/{id}", orderController.show);

    Router.resource("itemOrders", orderItemController);
    Router.get("/itemOrders/{id}", orderItemController.show);
    Router.delete("/itemOrders/{id}", orderItemController.destroy);
    Router.put("/itemOrders/{id}", orderItemController.update);
    },middleware: [AuthenticateMiddleware()]);
  }
}

