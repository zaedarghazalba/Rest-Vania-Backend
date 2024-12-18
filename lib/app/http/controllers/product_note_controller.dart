import 'package:vania/vania.dart';

import '../../models/product_note.dart';

class ProductNoteController extends Controller {

     Future<Response> index() async {
      final notes = await ProductNote().query().get();
      return Response.json({'message': 'success', 'data': notes});
     }

     Future<Response> create() async {
          return Response.json({});
     }

     Future<Response> store(Request request) async {
      var body = request.body;
      var insertnotes = await ProductNote().query().insert({
        'note_id': body['note_id'],
        'prod_id': body['prod_id'],
        'note_date': body['note_date'],
        'note_text': body['note_text'],
      });
      if (insertnotes != null) {
        return Response.json(
            {'message': 'Data inserted successfully', 'data': body});
      } else {
        return Response.json({'message': 'Failed to insert data'});
      }
     }

     Future<Response> show(String id) async {
      final notes = await ProductNote().query().where('note_id', '=', id).first();

      if (notes == null) {
        return Response.json({'message': 'Data not found'});
      }

      return Response.json({'message': 'Data found', 'data': notes});
     }

     Future<Response> edit(int id) async {
          return Response.json({});
     }

     Future<Response> update(Request request, id) async {
      await ProductNote().query().where('note_id', '=', id).update({
        'note_date': request.body['note_date'],
        'note_text': request.body['note_text'],
      });
      final notes = await ProductNote().query().where('note_id', '=', id).get();

      return Response.json({'message': 'Data updated', 'data': notes});
     }

     Future<Response> destroy( id) async {
      await ProductNote().query().where('note_id', '=', id).delete();
      return Response.json({'message': 'Data deleted'});
     }
}

final ProductNoteController productNoteController = ProductNoteController();

