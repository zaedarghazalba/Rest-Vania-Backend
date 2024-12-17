import 'package:mobile_vania/app/models/order.dart';
import 'package:vania/vania.dart';

class OrderController extends Controller {
  Future<Response> index() async {
    final orders = await Order().query().get();
    return Response.json({'message': 'success', 'data': orders});
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    var body = request.body;
    var lastOrder =
        await Order().query().orderBy('order_num', 'desc').limit(1).first();

    var newOrderNum = lastOrder != null ? lastOrder['order_num'] + 1 : 1;
    var data = {
      'order_num': newOrderNum,
      'order_date': DateTime.now(),
      'cust_id': body['cust_id'],
    };
    var insertOrder = await Order().query().insert(data);

    if (insertOrder != null) {
      return Response.json(
          {'message': 'Data inserted successfully', 'data': data});
    } else {
      return Response.json({'message': 'Failed to insert data'});
    }
  }

  Future<Response> show(int id) async {
    final orders =
        await Order().query().where('order_num', '=', id).first();

    if (orders == null) {
      return Response.json({'message': 'Data not found'});
    }

    return Response.json({'message': 'Data found', 'data': orders});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    await Order().query().where('vend_id', '=', id).update({
      'vend_name': request.body['vend_name'],
      'vend_address': request.body['vend_address'],
      'vend_kota': request.body['vend_kota'],
      'vend_state': request.body['vend_state'],
      'vend_zip': request.body['vend_zip'],
      'vend_country': request.body['vend_country'],
    });
    final orders = await Order().query().where('vend_id', '=', id).get();

    return Response.json({'message': 'Data berhasil Update','data': orders });
  }

  Future<Response> destroy(int id) async {
    await Order().query().where('order_num', '=', id).delete();
    return Response.json({'message': 'Data terhapus'});
  }
}

final OrderController orderController = OrderController();
