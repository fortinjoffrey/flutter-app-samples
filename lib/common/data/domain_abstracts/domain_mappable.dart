/// [E] for entity type
abstract class DomainMappable<E> {
  E toEntity();
}

/// [D] stands for Dto
/// [E] stands for Entity
extension ListX<E, D extends DomainMappable<E>> on List<D> {
  // TODO: on paper calling this on a List<D extends DomainMappable<E>> should work
  // TODO: in reality it returns a List<dynamic>
  // TODO: see why
  List<E> toEntityList() {
    return map((e) => e.toEntity()).toList();
  }
}
