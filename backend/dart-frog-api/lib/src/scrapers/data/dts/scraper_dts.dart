import 'package:eesup_dart_frog/src/scrapers/data/models/product_reference.dart';
import 'package:supabase/supabase.dart';

abstract class ScraperDataSource {
  Future<bool> submitProduct(String table, ScraperProduct product);
}

const _url = "https://xlezzqpkeiiyfdfkogwd.supabase.co";
const _key =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhsZXp6cXBrZWlpeWZkZmtvZ3dkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxMTI2ODI0NywiZXhwIjoyMDI2ODQ0MjQ3fQ.g7UeP48h6qn8bQ923OFpG9elevkPwURZQ1cyz4lyCXc";

class ScraperDtsImpl implements ScraperDataSource {
  final supabase = SupabaseClient(_url, _key);

  @override
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
      print(e);
      return false;
    }
  }
}
