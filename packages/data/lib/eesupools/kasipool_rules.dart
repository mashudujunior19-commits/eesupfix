/// The minimum total (ZAR) a KasiPool order, master order or consolidated
/// order needs before it can close.
///
/// The database is the authority (`communities.min_kasipool_order()`); this
/// mirrors it for the UI only. Change both together.
const double minKasipoolOrder = 10000;
