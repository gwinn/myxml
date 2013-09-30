#####################################################
#
# Author: alex@lushpai.org
#
#####################################################

package MyXML::Excel;

use strict;
use utf8;


BEGIN {
    our $VERSION = 1.0.22;
}

sub shExcel {
    #generate simple head of Excel XML
    my ($self,$ver) = (shift,shift);
    my $header = {
        'declaration' => '<?xml version="'.$ver.'"?>',
        'application' => '<?mso-application progid="Excel.Sheet"?>',
    };
    bless $header, $self;
    return $header;
};

sub sbExcel {
    #generate simple body of Excel XML
    our ($self,$data,$shift) = (shift,shift,undef);
    #warn Dumper $data;
    my $header = {
        'workbook' => MyXML::Generator->GXD(
            "Workbook",
            join ('',
                MyXML::Generator->GXD(
                    "Worksheet",
                    join ('',
                        MyXML::Generator->GXD(
                            "Table",
                            join ('',
                                MyXML::Generator->GXDM(
                                    "Column",
                                    ['ss:AutoFitWidth="0"','ss:Width="170"'],
                                )->{'result'},
                                MyXML::Generator->GXDM(
                                    "Column",
                                    ['ss:AutoFitWidth="0"','ss:Width="60.75"','ss:Span="254"'],
                                )->{'result'},
                                map {
                                    $shift=$_;
                                    join '',
                                    MyXML::Generator->GXD(
                                        "Row",
                                        MyXML::Generator->GXD(
                                            "Cell",
                                            MyXML::Generator->GXD(
                                                "Data",
                                                $_,
                                                ['ss:Type="String"']
                                            )->{'result'}
                                        )->{'result'},
                                    )->{'result'},
                                    map {
                                        MyXML::Generator->GXD(
                                            "Row",
                                            join '',
                                            MyXML::Generator->GXD(
                                                "Cell",
                                                MyXML::Generator->GXD(
                                                    "Data",
                                                    $_,
                                                    ['ss:Type="String"']
                                                )->{'result'}
                                            )->{'result'},
                                            MyXML::Generator->GXD(
                                                "Cell",
                                                MyXML::Generator->GXD(
                                                    "Data",
                                                    $data->{$shift}->{$_},
                                                    ['ss:Type="String"'],
                                                )->{'result'}
                                            )->{'result'},
                                        )->{'result'},
                                    } keys %{$data->{$_}},
                                } keys %{$data},
                            ),
                        )->{'result'},
                    ),
                    ['ss:Name="Statistic"'],
                )->{'result'},
            ),
            ['xmlns="urn:schemas-microsoft-com:office:spreadsheet"','xmlns:o="urn:schemas-microsoft-com:office:office"','xmlns:x="urn:schemas-microsoft-com:office:excel"','xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"','xmlns:html="http://www.w3.org/TR/REC-html40"'],
        )->{'result'},
    };
    bless $header, $self;
    return $header;
};

1;
