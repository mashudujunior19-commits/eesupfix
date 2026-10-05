/// TOWRIS Business groups businesses into 8 commercial verticals instead of
/// a long flat list of industries: the same supply chain (sugar, milk, oil,
/// cleaning chemicals, toilet paper, beverages, packaging, ...) serves a
/// hotel, a school, a spaza and a shisanyama alike.
///
/// Each vertical lists formal business types first, then "Likely Informal
/// and Township Businesses" -- fragmented businesses that usually buy small
/// quantities at relatively poor prices, and a key market for aggregated
/// buying.
library;

class BusinessType {
  const BusinessType(
    this.name, {
    required this.purchases,
    this.examples,
    this.isInformal = false,
  });

  final String name;

  /// Typical examples, shown to help people find their business.
  final String? examples;

  /// What this kind of business typically buys through TOWRIS.
  final String purchases;

  final bool isInformal;
}

class CommercialVertical {
  const CommercialVertical(this.name, this.businessTypes);

  final String name;
  final List<BusinessType> businessTypes;

  List<BusinessType> get formal =>
      businessTypes.where((b) => !b.isInformal).toList();

  List<BusinessType> get informal =>
      businessTypes.where((b) => b.isInformal).toList();

  static CommercialVertical? byName(String? name) {
    for (final v in commercialVerticals) {
      if (v.name == name) return v;
    }
    return null;
  }
}

const informalBusinessesLabel = 'Likely Informal and Township Businesses';

const List<CommercialVertical> commercialVerticals = [
  CommercialVertical('Food, Grocery & Hospitality', [
    BusinessType('Hotels',
        purchases: 'Food, beverages, cleaning, toiletries, linen consumables'),
    BusinessType('Guesthouses, lodges & B&Bs',
        purchases: 'Food, beverages, cleaning, toiletries, linen consumables'),
    BusinessType('Restaurants & cafés',
        purchases: 'Ingredients, beverages, packaging, cleaning supplies'),
    BusinessType('Fast-food outlets',
        purchases: 'Ingredients, beverages, packaging, cleaning supplies'),
    BusinessType('Catering companies',
        purchases: 'Ingredients, beverages, packaging, cleaning supplies'),
    BusinessType('Student accommodation',
        purchases: 'Food, cleaning, hygiene and household products'),
    BusinessType('Street food',
        examples: 'Kota, amagwinya, chips, braai, chicken vendors',
        purchases: 'Ingredients, oil, sauces, packaging',
        isInformal: true),
    BusinessType('Taverns / Shebeens',
        examples: 'Township entertainment venues',
        purchases: 'Mixers, soft drinks, snacks, food, cleaning supplies',
        isInformal: true),
    BusinessType('Shisanyamas',
        examples: 'Township restaurants/braai businesses',
        purchases: 'Meat, beverages, charcoal, sauces, packaging',
        isInformal: true),
    BusinessType('Caterers',
        examples: 'Home-based and event caterers',
        purchases: 'Bulk ingredients, beverages, packaging',
        isInformal: true),
    BusinessType('Bakeries',
        examples: 'Home and township bakeries',
        purchases: 'Flour, sugar, oil, yeast, packaging',
        isInformal: true),
    BusinessType('Confectionery businesses',
        examples: 'Cakes, sweets, desserts',
        purchases: 'Ingredients and packaging',
        isInformal: true),
    BusinessType('Butcheries',
        examples: 'Independent township butcheries',
        purchases: 'Meat, spices, packaging and cleaning',
        isInformal: true),
    BusinessType('Chicken businesses',
        examples: 'Live chicken, poultry sellers, fast food',
        purchases: 'Poultry, feed-related products, packaging',
        isInformal: true),
    BusinessType('Mobile food vendors',
        examples: 'Food trucks, trailers, roadside vendors',
        purchases: 'Ingredients, packaging and beverages',
        isInformal: true),
    BusinessType('Informal accommodation',
        examples: 'Rooms, guesthouses, Airbnb-type operators',
        purchases: 'Linen-related consumables, toiletries, cleaning',
        isInformal: true),
  ]),
  CommercialVertical('Retail & Resellers', [
    BusinessType('Supermarkets',
        purchases: 'Groceries, beverages, toiletries, cleaning products'),
    BusinessType('Convenience stores & mini-markets',
        purchases: 'Groceries, beverages, toiletries, cleaning products'),
    BusinessType('Independent retailers',
        purchases: 'Groceries, beverages, toiletries, cleaning products'),
    BusinessType('Spaza shops',
        examples: 'Township convenience stores',
        purchases: 'FMCG at wholesale/aggregated prices',
        isInformal: true),
    BusinessType('Tuck shops',
        examples: 'School, workplace and community tuck shops',
        purchases: 'Snacks, beverages, groceries',
        isInformal: true),
    BusinessType('Fruit & vegetable traders',
        examples: 'Hawkers and stalls',
        purchases: 'Produce, packaging, logistics',
        isInformal: true),
    BusinessType('Street traders / Hawkers',
        examples: 'Snacks, drinks, household goods',
        purchases: 'Resale inventory',
        isInformal: true),
    BusinessType('Market stallholders',
        examples: 'Formal and informal markets',
        purchases: 'Stock and packaging',
        isInformal: true),
  ]),
  CommercialVertical('Education & ECD', [
    BusinessType('Schools',
        purchases: 'Food, stationery, cleaning, hygiene, consumables'),
    BusinessType('Colleges & universities',
        purchases: 'Food, stationery, cleaning, hygiene, consumables'),
    BusinessType('ECD centres',
        purchases: 'Food, stationery, cleaning, hygiene, consumables'),
    BusinessType('Creches / ECD centres',
        examples: 'Community and home-based centres',
        purchases: 'Food, nappies, cleaning, hygiene products',
        isInformal: true),
    BusinessType('Informal daycare',
        examples: 'Child minders',
        purchases: 'Food, toiletries and household consumables',
        isInformal: true),
  ]),
  CommercialVertical('Health, Beauty & Personal Care', [
    BusinessType('Clinics & medical practices',
        purchases: 'Hygiene, cleaning, food, non-clinical consumables'),
    BusinessType('Care homes',
        purchases: 'Hygiene, cleaning, food, non-clinical consumables'),
    BusinessType('Salon, spa & barbershop groups',
        purchases: 'Beauty consumables, cleaning and refreshments'),
    BusinessType('Hair salons',
        examples: 'Township and home salons',
        purchases: 'Hair products, consumables, cleaning supplies',
        isInformal: true),
    BusinessType('Barbershops',
        examples: 'Township barbers',
        purchases: 'Blades, sanitiser, towels, grooming consumables',
        isInformal: true),
    BusinessType('Nail & beauty businesses',
        examples: 'Home studios, mobile beauty operators',
        purchases: 'Beauty and hygiene consumables',
        isInformal: true),
  ]),
  CommercialVertical('Automotive & Mobility', [
    BusinessType('Dealerships',
        purchases: 'Cleaning, workshop consumables, refreshments'),
    BusinessType('Workshops & fitment centres',
        purchases: 'Cleaning, workshop consumables, refreshments'),
    BusinessType('Taxi & bus companies',
        purchases: 'Cleaning, vehicle consumables, refreshments, PPE'),
    BusinessType('Couriers & fleets',
        purchases: 'Cleaning, vehicle consumables, refreshments, PPE'),
    BusinessType('Car washes',
        examples: 'Formal and informal car washes',
        purchases: 'Chemicals, cloths, PPE, refreshments',
        isInformal: true),
    BusinessType('Mechanics',
        examples: 'Backyard mechanics',
        purchases: 'Consumables, cleaning products, PPE',
        isInformal: true),
    BusinessType('Tyre businesses',
        examples: 'Fitment and puncture repair',
        purchases: 'Consumables and cleaning',
        isInformal: true),
    BusinessType('Panel beaters',
        examples: 'Small workshops',
        purchases: 'PPE and workshop consumables',
        isInformal: true),
    BusinessType('Transport operators',
        examples: 'Taxi owners, scholar transport',
        purchases: 'Cleaning and operating consumables',
        isInformal: true),
    BusinessType('Delivery operators',
        examples: 'Local couriers and drivers',
        purchases: 'PPE, packaging and vehicle-related consumables',
        isInformal: true),
  ]),
  CommercialVertical('Property, Cleaning & Facilities', [
    BusinessType('Property & facilities management',
        examples: 'Shopping centres, estates, office parks',
        purchases: 'Cleaning, hygiene, maintenance consumables'),
    BusinessType('Corporate offices',
        examples: 'Banks, professional firms, call centres',
        purchases: 'Tea/coffee, refreshments, stationery, hygiene, cleaning'),
    BusinessType('Security services',
        purchases: 'Uniform consumables, refreshments, toiletries, cleaning'),
    BusinessType('Laundry businesses',
        examples: 'Township laundromats/home laundries',
        purchases: 'Detergents, softeners, bleach',
        isInformal: true),
    BusinessType('Cleaning businesses',
        examples: 'Domestic and commercial cleaners',
        purchases: 'Chemicals, equipment and PPE',
        isInformal: true),
    BusinessType('Handymen / Maintenance',
        examples: 'Plumbers, electricians, maintenance crews',
        purchases: 'PPE and general consumables',
        isInformal: true),
  ]),
  CommercialVertical('Construction, Manufacturing & Industrial', [
    BusinessType('Construction contractors & developers',
        purchases: 'PPE, water, cleaning, food, site consumables'),
    BusinessType('Manufacturing',
        examples: 'Factories and industrial companies',
        purchases: 'PPE, cleaning, refreshments, office and operational '
            'supplies'),
    BusinessType('Mining & resources',
        examples: 'Mines, contractors, worker accommodation',
        purchases: 'Food, PPE, hygiene, cleaning, general consumables'),
    BusinessType('Agriculture',
        examples: 'Farms, pack houses, cooperatives',
        purchases: 'Food, PPE, cleaning, packaging and operating '
            'consumables'),
    BusinessType('Construction teams',
        examples: 'Small builders and subcontractors',
        purchases: 'PPE, refreshments, site consumables',
        isInformal: true),
    BusinessType('Tailors / Fashion businesses',
        examples: 'Seamstresses, designers',
        purchases: 'Packaging and selected production consumables',
        isInformal: true),
  ]),
  CommercialVertical('Community, Events & Institutions', [
    BusinessType('NGOs, NPCs & community organisations',
        examples: 'NPOs, churches, feeding schemes',
        purchases: 'Food parcels, groceries, hygiene products'),
    BusinessType('Government & public sector',
        examples: 'Municipal facilities, departments, public entities',
        purchases: 'Cleaning, food, office and facility consumables'),
    BusinessType('Events & entertainment',
        examples: 'Venues, event companies, sports clubs',
        purchases: 'Beverages, food, packaging, cleaning products'),
    BusinessType('Funeral services',
        examples: 'Funeral parlours and undertakers',
        purchases: 'Catering, beverages, cleaning, consumables'),
    BusinessType('Photographers / Events businesses',
        examples: 'Informal event services',
        purchases: 'Batteries, stationery, refreshments',
        isInformal: true),
    BusinessType('Decorators',
        examples: 'Weddings, funerals, parties',
        purchases: 'Cleaning, disposable items and consumables',
        isInformal: true),
    BusinessType('Funeral-service SMEs',
        examples: 'Township undertakers',
        purchases: 'Catering and operational supplies',
        isInformal: true),
    BusinessType('Internet cafés',
        examples: 'Printing/copy businesses',
        purchases: 'Paper, stationery, refreshments',
        isInformal: true),
    BusinessType('Churches',
        examples: 'Congregations and ministries',
        purchases: 'Groceries, catering, cleaning',
        isInformal: true),
    BusinessType('Stokvels / Buying clubs',
        examples: 'Household and business buying groups',
        purchases: 'Aggregated groceries and bulk purchases',
        isInformal: true),
  ]),
];
