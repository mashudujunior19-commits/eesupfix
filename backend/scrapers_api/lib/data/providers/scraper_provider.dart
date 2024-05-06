import 'package:scrapers_api/data/models/product_reference.dart';
import 'package:supabase/supabase.dart';

const _url = 'https://xlezzqpkeiiyfdfkogwd.supabase.co';
const _key =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhsZ'
    'Xp6cXBrZWlpeWZkZmtvZ3dkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxMTI2ODI'
    '0NywiZXhwIjoyMDI2ODQ0MjQ3fQ.g7UeP48h6qn8bQ923OFpG9elevkPwURZQ1cyz4lyCXc';

class ScraperDataProvider {
  final supabase = SupabaseClient(_url, _key);

  Future<bool> submitProduct(String table, ScraperProduct product) async {
    try {
      // add to the specific table
      await supabase.schema('scraper').from(table).insert(product.toMap());
      //insert to the scaper table
      await supabase
          .schema('scraper')
          .from('scraper_product')
          .insert(product.toMap());
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
}
