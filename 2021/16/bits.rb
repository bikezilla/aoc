class Input
  attr_reader :binary, :cursor

  def initialize(input)
    @binary = input
    @cursor = 0
  end

  def read(length)
    @binary[@cursor...(@cursor += length)]
  end

  def finished?
    (@cursor >= @binary.size - 1) || /^0+$/.match(@binary[@cursor..])
  end
end

Literal = Struct.new :version, :value do
  def version_sum
    version
  end
end

Operator = Struct.new :version, :type_id, :sub_packets do
  def version_sum
    version + sub_packets.sum(&:version_sum)
  end

  def value
    case type_id
    when 0 then sub_packets.map(&:value).sum
    when 1 then sub_packets.map(&:value).reduce(:*)
    when 2 then sub_packets.map(&:value).min
    when 3 then sub_packets.map(&:value).max
    when 5 then sub_packets[0].value > sub_packets[1].value ? 1 : 0
    when 6 then sub_packets[0].value < sub_packets[1].value ? 1 : 0
    when 7 then sub_packets[0].value == sub_packets[1].value ? 1 : 0
    end
  end
end

@input = Input.new (STDIN.tty? ? DATA : STDIN).read.chars.map { _1.to_i(16).to_s(2).rjust(4, '0') }.join

def read_packet(input)
  version = input.read(3).to_i(2)
  type_id = input.read(3).to_i(2)

  if type_id == 4
    literal_binary = ''

    loop do
      bit_group = input.read(5)
      literal_binary += bit_group[1..]

      break if bit_group[0] == '0'
    end

    Literal.new version, literal_binary.to_i(2)
  else
    length_type = input.read(1)

    if length_type == '0'
      length = input.read(15).to_i(2)

      sub_input = Input.new(input.read(length))
      sub_packets = []
      loop do
        sub_packets << read_packet(sub_input)
        break if sub_input.finished?
      end

      Operator.new version, type_id, sub_packets
    else
      count = input.read(11).to_i(2)
      sub_packets = count.times.map { read_packet(input) }

      Operator.new version, type_id, sub_packets
    end
  end
end

packets = []

loop do
  packets << read_packet(@input)
  break if @input.finished?
end

#pp packets
p packets.sum(&:version_sum)
p packets.sum(&:value)

__END__
E0529D18025800ABCA6996534CB22E4C00FB48E233BAEC947A8AA010CE1249DB51A02CC7DB67EF33D4002AE6ACDC40101CF0449AE4D9E4C071802D400F84BD21CAF3C8F2C35295EF3E0A600848F77893360066C200F476841040401C88908A19B001FD35CCF0B40012992AC81E3B980553659366736653A931018027C87332011E2771FFC3CEEC0630A80126007B0152E2005280186004101060C03C0200DA66006B8018200538012C01F3300660401433801A6007380132DD993100A4DC01AB0803B1FE2343500042E24C338B33F5852C3E002749803B0422EC782004221A41A8CE600EC2F8F11FD0037196CF19A67AA926892D2C643675A0C013C00CC0401F82F1BA168803510E3942E969C389C40193CFD27C32E005F271CE4B95906C151003A7BD229300362D1802727056C00556769101921F200AC74015960E97EC3F2D03C2430046C0119A3E9A3F95FD3AFE40132CEC52F4017995D9993A90060729EFCA52D3168021223F2236600ECC874E10CC1F9802F3A71C00964EC46E6580402291FE59E0FCF2B4EC31C9C7A6860094B2C4D2E880592F1AD7782992D204A82C954EA5A52E8030064D02A6C1E4EA852FE83D49CB4AE4020CD80272D3B4AA552D3B4AA5B356F77BF1630056C0119FF16C5192901CEDFB77A200E9E65EAC01693C0BCA76FEBE73487CC64DEC804659274A00CDC401F8B51CE3F8803B05217C2E40041A72E2516A663F119AC72250A00F44A98893C453005E57415A00BCD5F1DD66F3448D2600AC66F005246500C9194039C01986B317CDB10890C94BF68E6DF950C0802B09496E8A3600BCB15CA44425279539B089EB7774DDA33642012DA6B1E15B005C0010C8C917A2B880391160944D30074401D845172180803D1AA3045F00042630C5B866200CC2A9A5091C43BBD964D7F5D8914B46F040
