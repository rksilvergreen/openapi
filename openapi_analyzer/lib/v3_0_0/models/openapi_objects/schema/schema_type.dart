/// JSON Schema type values for Schema Objects.
enum SchemaType {
  string('string'),
  number('number'),
  integer('integer'),
  boolean('boolean'),
  array('array'),
  object('object'),
  null_('null'),
  unknown('unknown'),
  multiType('multiType');

  const SchemaType(this.value);
  final String value;
}