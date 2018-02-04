#!/usr/bin/env python3 
import sys

def header():
    print('TACAN\tVOR_FREQ\tPAIR\tUNOFF')
    print('-')


class TACAN(object):
    X_CHANNELS = (
      (1, 16, 134.3),
      (17, 59, 106.3),
      (60, 69, 127.3),
      (70, 126, 105.3),
    )
    Y_VOR_OFFSET = 0.05

    def __init__(self, tacan):
        self.tacan = tacan.upper()

    @property
    def chan(self):
        return int(self.tacan[:-1])

    @property
    def band(self):
        return self.tacan[-1]

    @property
    def vor_offset(self):
        offset = self.chan / 10.0
        if self.band == 'Y':
            offset += self.Y_VOR_OFFSET
        return offset

    @property
    def pair(self):
        pair_chan = self.chan + 63 if self.chan < 64 else self.chan - 63
        return '{}{}'.format(pair_chan, self.band)

    @property
    def vor(self):
        for low_chan, high_chan, band_freq in self.X_CHANNELS:
            if low_chan <= self.chan <= high_chan:
                return round(band_freq + self.vor_offset, 2)

    @property
    def unoff(self):
        # Only the Y channels from 17Y up to 69Y "officially" have a VOR pair freq
        # They're still included in the output in case whatever sim you're using
        # doesn't include this specific check for unofficial Y-band frequencies
        if self.band == 'Y' and (self.chan < 17 or self.chan > 69):
            return '*'
        return ''

    def print_line(self):
        print('{}\t{}MHz\t{}\t{}'.format(self.tacan, self.vor, self.pair, self.unoff))

    def __repr__(self):
        return '{}("{}")'.format(type(self).__name__, self.tacan)

    def __str__(self):
        return self.tacan

    def __lt__(self, other):
        # TACANs are comparable to other TACANS only
        if self.chan == other.chan:
            return self.band < other.band
        else:
            return self.chan < other.chan

    @classmethod
    def generate(cls, mutate_dict):
        for low_chan, high_chan, band_freq in TACAN.X_CHANNELS: 
            for chan in range(low_chan, high_chan + 1):
                for band in ('X', 'Y'):
                    tacan = '{}{}'.format(chan, band)
                    mutate_dict[tacan] = cls(tacan)
                    
        
tacans = {}
TACAN.generate(tacans)

if __name__ == '__main__':
    try:
        tacan = sys.argv[1].upper()
        header()
        tacans[tacan].print_line()
    except IndexError:
        # no argv 1, print all channels
        header()
        for tacan in sorted(tacans.values()):
            tacan.print_line()
    except KeyError:
        print('TACAN {} Unknown'.format(tacan))
        sys.exit(1)

    print('')
    print('The PAIR channel is used for setting up TACAN T/R pairs between aircraft.')
    print(' e.g. An aircraft receiving on 1X will transmit on its pair, 64X in T/R mode.')
    print('      Pairing aircraft should then receive on 64X in T/R mode to transmit on 1X.')
    print('')
    print('*: Channels marked unofficial do not have a canonical VOR but are still deriveable')
    print('   from their X-band counterpart. They are included here in the event that they are')
    print('   implemented in the simulator.')
