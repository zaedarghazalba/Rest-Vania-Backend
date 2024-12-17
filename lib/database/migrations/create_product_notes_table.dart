import 'package:vania/vania.dart';

class CreateProductNotesTable extends Migration {
  @override
  Future<void> up() async {
        super.up();
    await createTableNotExists('product_notes', () {
      char('note_id', length: 5);
      primary('note_id');
      char('prod_id', length: 10);
      foreign('prod_id', 'products', 'prod_id', constrained: true, onDelete: 'CASCADE');
      date('note_date');
      text('note_text');
    });
  }
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('product_notes');
  }
}
