//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 06.01.2024.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}

//{
//    href = "https://api.spotify.com/v1/me/albums?offset=0&limit=1&locale=en-US,en;q=0.9";
//    items =     (
//                {
//            "added_at" = "2024-01-06T12:57:09Z";
//            album =             {
//                "album_type" = album;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/27T030eWyCQRmDyuvr1kxY";
//                        };
//                        href = "https://api.spotify.com/v1/artists/27T030eWyCQRmDyuvr1kxY";
//                        id = 27T030eWyCQRmDyuvr1kxY;
//                        name = Scorpions;
//                        type = artist;
//                        uri = "spotify:artist:27T030eWyCQRmDyuvr1kxY";
//                    }
//                );
//                "available_markets" =                 (
//                    AU,
//                    AT,
//                    BE,
//                    BG,
//
//                            "disc_number" = 1;
//                            "duration_ms" = 158013;
//                            explicit = 0;
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/track/4xR6R8swmsJmry3rks6LlG";
//                            };
//                            href = "https://api.spotify.com/v1/tracks/4xR6R8swmsJmry3rks6LlG";
//                            id = 4xR6R8swmsJmry3rks6LlG;
//                            "is_local" = 0;
//                            name = "Can't Get Enough (2015 - Remaster)";
//                            "preview_url" = "https://p.scdn.co/mp3-preview/961524946fc71457f1d02b59add8cb8c997a6de0?cid=4a8e12d2b3734c14a6b7539ba30fe981";
//                            "track_number" = 5;
//                            type = track;
//                            uri = "spotify:track:4xR6R8swmsJmry3rks6LlG";
//                        },
//                                                {
//                            artists =                             (
//                                                                {
//                                    "external_urls" =                                     {
//                                        spotify = "https://open.spotify.com/artist/27T030eWyCQRmDyuvr1kxY";
//                                    };
//                                    href = "https://api.spotify.com/v1/artists/27T030eWyCQRmDyuvr1kxY";
//                                    id = 27T030eWyCQRmDyuvr1kxY;
//                                    name = Scorpions;
//                                    type = artist;
//                                    uri = "spotify:artist:27T030eWyCQRmDyuvr1kxY";
//                                }
//                            );
//                            "available_markets" =                             (
//                                AU,
//                                AT,
//                                BE,
//                                BG,
//                                CY,
//                                CZ,
//                                DK,
//                                DE,
//                                EE,
//                                FI,
//                                FR,
//                                GR,
//                                HK,
//                                HU,
//                                IS,
//                                IE,
//                                IT,
//                                LV,
//                                LT,
//                                LU,
//                                MY,
//                                MT,
//                                NL,
//                                NZ,
//                                NO,
//                                PH,
//                                PL,
//                                PT,
//                                SG,
//                                SK,
//                                ES,
//                                SE,
//                                CH,
//                                TW,
//                                TR,
//                                GB,
//                                AD,
//                                LI,
//                                MC,
//                                ID,
//                                JP,
//                                TH,
//                                VN,
//                                RO,
//                                IL,
//                                ZA,
//                                SA,
//                                AE,
//                                BH,
//                                QA,
//                                OM,
//                                KW,
//                                EG,
//                                MA,
//                                DZ,
//                                TN,
//                                LB,
//                                JO,
//                                PS,
//                                IN,
//                                BY,
//                                KZ,
//                                MD,
//                                UA,
//                                AL,
//                                BA,
//                                HR,
//                                ME,
//                                MK,
//                                RS,
//                                SI,
//                                KR,
//                                BD,
//                                PK,
//                                LK,
//                                GH,
//                                KE,
//                                NG,
//                                TZ,
//                                UG,
//                                AM,
//                                BT,
//                                BW,
//                                BF,
//                                CV,
//                                CW,
//                                FJ,
//                                GM,
//                                GE,
//                                GW,
//                                KI,
//                                LS,
//                                LR,
//                                MW,
//                                MV,
//                                ML,
//                                MH,
//                                FM,
//                                NA,
//                                NR,
//                                NE,
//                                PW,
//                                PG,
//                                WS,
//                                SM,
//                                ST,
//                                SN,
//                                SC,
//                                SL,
//                                TL,
//                                TO,
//                                TV,
//                                VU,
//                                AZ,
//                                BN,
//                                BI,
//                                KH,
//                                CM,
//                                TD,
//                                KM,
//                                GQ,
//                                SZ,
//                                GA,
//                                GN,
//                                KG,
//                                LA,
//                                MO,
//                                MR,
//                                MN,
//                                NP,
//                                RW,
//                                TG,
//                                UZ,
//                                ZW,
//                                BJ,
//                                MG,
//                                MU,
//                                MZ,
//                                AO,
//                                CI,
//                                DJ,
//                                ZM,
//                                CD,
//                                CG,
//                                IQ,
//                                LY,
//                                TJ,
//                                ET,
//                                XK
//                            );
//                            "disc_number" = 1;
//                            "duration_ms" = 239400;
//                            explicit = 0;
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/track/1evLWOWq8797z8c4pH6t5k";
//                            };
//                            href = "https://api.spotify.com/v1/tracks/1evLWOWq8797z8c4pH6t5k";
//                            id = 1evLWOWq8797z8c4pH6t5k;
//                            "is_local" = 0;
//                            name = "Is There Anybody There? (2015 - Remaster)";
//                            "preview_url" = "https://p.scdn.co/mp3-preview/0a290ad17d4dbee6186e9bf93588a1eb5fa744e2?cid=4a8e12d2b3734c14a6b7539ba30fe981";
//                            "track_number" = 6;
//                            type = track;
//                            uri = "spotify:track:1evLWOWq8797z8c4pH6t5k";
//                        },
//                                                {
//                            artists =                             (
//                                                                {
//                                    "external_urls" =                                     {
//                                        spotify = "https://open.spotify.com/artist/27T030eWyCQRmDyuvr1kxY";
//                                    };
//                                    href = "https://api.spotify.com/v1/artists/27T030eWyCQRmDyuvr1kxY";
//                                    id = 27T030eWyCQRmDyuvr1kxY;
//                                    name = Scorpions;
//                                    type = artist;
//                                    uri = "spotify:artist:27T030eWyCQRmDyuvr1kxY";
//                                }
//                            );
//                            "available_markets" =                             (
//                                AU,
//                                AT,
//                                BE,
//                                BG,
//                                CY,
//                                CZ,
//                                DK,
//                                DE,
//                                EE,
//                                FI,
//                                FR,
//                                GR,
//                                HK,
//                                HU,
//                                IS,
//                                IE,
//                                IT,
//                                LV,
//                                LT,
//                                LU,
//                                MY,
//                                MT,
//                                NL,
//                                NZ,
//                                NO,
//                                PH,
//                                PL,
//                                PT,
//                                SG,
//                                SK,
//                                ES,
//                                SE,
//                                CH,
//                                TW,
//                                TR,
//                                GB,
//                                AD,
//                                LI,
//                                MC,
//                                ID,
//                                JP,
//                                TH,
//                                VN,
//                                RO,
//                                IL,
//                                ZA,
//                                SA,
//                                AE,
//                                BH,
//                                QA,
//                                OM,
//                                KW,
//                                EG,
//                                MA,
//                                DZ,
//                                TN,
//                                LB,
//                                JO,
//                                PS,
//                                IN,
//                                BY,
//                                KZ,
//                                MD,
//                                UA,
//                                AL,
//                                BA,
//                                HR,
//                                ME,
//                                MK,
//                                RS,
//                                SI,
//                                KR,
//                                BD,
//                                PK,
//                                LK,
//                                GH,
//                                KE,
//                                NG,
//                                TZ,
//                                UG,
//                                AM,
//                                BT,
//                                BW,
//                                BF,
//                                CV,
//                                CW,
//                                FJ,
//                                GM,
//                                GE,
//                                GW,
//                                KI,
//                                LS,
//                                LR,
//                                MW,
//                                MV,
//                                ML,
//                                MH,
//                                FM,
//                                NA,
//                                NR,
//                                NE,
//                                PW,
//                                PG,
//                                WS,
//                                SM,
//                                ST,
//                                SN,
//                                SC,
//                                SL,
//                                TL,
//                                TO,
//                                TV,
//                                VU,
//                                AZ,
//                                BN,
//                                BI,
//                                KH,
//                                CM,
//                                TD,
//                                KM,
//                                GQ,
//                                SZ,
//                                GA,
//                                GN,
//                                KG,
//                                LA,
//                                MO,
//                                MR,
//                                MN,
//                                NP,
//                                RW,
//                                TG,
//                                UZ,
//                                ZW,
//                                BJ,
//                                MG,
//                                MU,
//                                MZ,
//                                AO,
//                                CI,
//                                DJ,
//                                ZM,
//                                CD,
//                                CG,
//                                IQ,
//                                LY,
//                                TJ,
//                                ET,
//                                XK
//                            );
//                            "disc_number" = 1;
//                            "duration_ms" = 292120;
//                            explicit = 0;
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/track/1h7OpWts0S9LgN4TAQoTc6";
//                            };
//                            href = "https://api.spotify.com/v1/tracks/1h7OpWts0S9LgN4TAQoTc6";
//                            id = 1h7OpWts0S9LgN4TAQoTc6;
//                            "is_local" = 0;
//                            name = "Lovedrive (2015 - Remaster)";
//                            "preview_url" = "https://p.scdn.co/mp3-preview/128a5284bece09f11345af5e4dda54d242c7d726?cid=4a8e12d2b3734c14a6b7539ba30fe981";
//                            "track_number" = 7;
//                            type = track;
//                            uri = "spotify:track:1h7OpWts0S9LgN4TAQoTc6";
//                        },
//                                                {
//                            artists =                             (
//                                                                {
//                                    "external_urls" =                                     {
//                                        spotify = "https://open.spotify.com/artist/27T030eWyCQRmDyuvr1kxY";
//                                    };
//                                    href = "https://api.spotify.com/v1/artists/27T030eWyCQRmDyuvr1kxY";
//                                    id = 27T030eWyCQRmDyuvr1kxY;
//                                    name = Scorpions;
//                                    type = artist;
//                                    uri = "spotify:artist:27T030eWyCQRmDyuvr1kxY";
//                                }
//                            );
//                            "available_markets" =                             (
//                                AU,
//                                AT,
//                                BE,
//                                BG,
//                                CY,
//                                CZ,
//                                DK,
//                                DE,
//                                EE,
//                                FI,
//                                FR,
//                                GR,
//                                HK,
//                                HU,
//                                IS,
//                                IE,
//                                IT,
//                                LV,
//                                LT,
//                                LU,
//                                MY,
//                                MT,
//                                NL,
//                                NZ,
//                                NO,
//                                PH,
//                                PL,
//                                PT,
//                                SG,
//                                SK,
//                                ES,
//                                SE,
//                                CH,
//                                TW,
//                                TR,
//                                GB,
//                                AD,
//                                LI,
//                                MC,
//                                ID,
//                                JP,
//                                TH,
//                                VN,
//                                RO,
//                                IL,
//                                ZA,
//                                SA,
//                                AE,
//                                BH,
//                                QA,
//                                OM,
//                                KW,
//                                EG,
//                                MA,
//                                DZ,
//                                TN,
//                                LB,
//                                JO,
//                                PS,
//                                IN,
//                                BY,
//                                KZ,
//                                MD,
//                                UA,
//                                AL,
//                                BA,
//                                HR,
//                                ME,
//                                MK,
//                                RS,
//                                SI,
//                                KR,
//                                BD,
//                                PK,
//                                LK,
//                                GH,
//                                KE,
//                                NG,
//                                TZ,
//                                UG,
//                                AM,
//                                BT,
//                                BW,
//                                BF,
//                                CV,
//                                CW,
//                                FJ,
//                                GM,
//                                GE,
//                                GW,
//                                KI,
//                                LS,
//                                LR,
//                                MW,
//                                MV,
//                                ML,
//                                MH,
//                                FM,
//                                NA,
//                                NR,
//                                NE,
//                                PW,
//                                PG,
//                                WS,
//                                SM,
//                                ST,
//                                SN,
//                                SC,
//                                SL,
//                                TL,
//                                TO,
//                                TV,
//                                VU,
//                                AZ,
//                                BN,
//                                BI,
//                                KH,
//                                CM,
//                                TD,
//                                KM,
//                                GQ,
//                                SZ,
//                                GA,
//                                GN,
//                                KG,
//                                LA,
//                                MO,
//                                MR,
//                                MN,
//                                NP,
//                                RW,
//                                TG,
//                                UZ,
//                                ZW,
//                                BJ,
//                                MG,
//                                MU,
//                                MZ,
//                                AO,
//                                CI,
//                                DJ,
//                                ZM,
//                                CD,
//                                CG,
//                                IQ,
//                                LY,
//                                TJ,
//                                ET,
//                                XK
//                            );
//                            "disc_number" = 1;
//                            "duration_ms" = 391360;
//                            explicit = 0;
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/track/73ej5lGd0Pyji6pbIBQ9fi";
//                            };
//                            href = "https://api.spotify.com/v1/tracks/73ej5lGd0Pyji6pbIBQ9fi";
//                            id = 73ej5lGd0Pyji6pbIBQ9fi;
//                            "is_local" = 0;
//                            name = "Holiday (2015 - Remaster)";
//                            "preview_url" = "https://p.scdn.co/mp3-preview/a48948513602f82ee63bba0c29ffc9ab907d4673?cid=4a8e12d2b3734c14a6b7539ba30fe981";
//                            "track_number" = 8;
//                            type = track;
//                            uri = "spotify:track:73ej5lGd0Pyji6pbIBQ9fi";
//                        },
//                                                {
//                            artists =                             (
//                                                                {
//                                    "external_urls" =                                     {
//                                        spotify = "https://open.spotify.com/artist/27T030eWyCQRmDyuvr1kxY";
//                                    };
//                                    href = "https://api.spotify.com/v1/artists/27T030eWyCQRmDyuvr1kxY";
//                                    id = 27T030eWyCQRmDyuvr1kxY;
//                                    name = Scorpions;
//                                    type = artist;
//                                    uri = "spotify:artist:27T030eWyCQRmDyuvr1kxY";
//                                }
//                            );
//                            "available_markets" =                             (
//                                AU,
//                                AT,
//                                BE,
//                                BG,
//                                CY,
//                                CZ,
//                                DK,
//                                DE,
//                                EE,
//                                FI,
//                                FR,
//                                GR,
//                                HK,
//                                HU,
//                                IS,
//                                IE,
//                                IT,
//                                LV,
//                                LT,
//                                LU,
//                                MY,
//                                MT,
//                                NL,
//                                NZ,
//                                NO,
//                                PH,
//                                PL,
//                                PT,
//                                SG,
//                                SK,
//                                ES,
//                                SE,
//                                CH,
//                                TW,
//                                TR,
//                                GB,
//                                AD,
//                                LI,
//                                MC,
//                                ID,
//                                JP,
//                                TH,
//                                VN,
//                                RO,
//                                IL,
//                                ZA,
//                                SA,
//                                AE,
//                                BH,
//                                QA,
//                                OM,
//                                KW,
//                                EG,
//                                MA,
//                                DZ,
//                                TN,
//                                LB,
//                                JO,
//                                PS,
//                                IN,
//                                BY,
//                                KZ,
//                                MD,
//                                UA,
//                                AL,
//                                BA,
//                                HR,
//                                ME,
//                                MK,
//                                RS,
//                                SI,
//                                KR,
//                                BD,
//                                PK,
//                                LK,
//                                GH,
//                                KE,
//                                NG,
//                                TZ,
//                                UG,
//                                AM,
//                                BT,
//                                BW,
//                                BF,
//                                CV,
//                                CW,
//                                FJ,
//                                GM,
//                                GE,
//                                GW,
//                                KI,
//                                LS,
//                                LR,
//                                MW,
//                                MV,
//                                ML,
//                                MH,
//                                FM,
//                                NA,
//                                NR,
//                                NE,
//                                PW,
//                                PG,
//                                WS,
//                                SM,
//                                ST,
//                                SN,
//                                SC,
//                                SL,
//                                TL,
//                                TO,
//                                TV,
//                                VU,
//                                AZ,
//                                BN,
//                                BI,
//                                KH,
//                                CM,
//                                TD,
//                                KM,
//                                GQ,
//                                SZ,
//                                GA,
//                                GN,
//                                KG,
//                                LA,
//                                MO,
//                                MR,
//                                MN,
//                                NP,
//                                RW,
//                                TG,
//                                UZ,
//                                ZW,
//                                BJ,
//                                MG,
//                                MU,
//                                MZ,
//                                AO,
//                                CI,
//                                DJ,
//                                ZM,
//                                CD,
//                                CG,
//                                IQ,
//                                LY,
//                                TJ,
//                                ET,
//                                XK
//                            );
//                            "disc_number" = 1;
//                            "duration_ms" = 271880;
//                            explicit = 0;
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/track/21Pfyk8wc52LxIfBKupgcU";
//                            };
//                            href = "https://api.spotify.com/v1/tracks/21Pfyk8wc52LxIfBKupgcU";
//                            id = 21Pfyk8wc52LxIfBKupgcU;
//                            "is_local" = 0;
//                            name = "Cause I Love You (Demo Version)";
//                            "preview_url" = "https://p.scdn.co/mp3-preview/10e8af79b9487812ab05c24d512ce967a3ee1f5f?cid=4a8e12d2b3734c14a6b7539ba30fe981";
//                            "track_number" = 9;
//                            type = track;
//                            uri = "spotify:track:21Pfyk8wc52LxIfBKupgcU";
//                        },
//                                                {
//                            artists =                             (
//                                                                {
//                                    "external_urls" =                                     {
//                                        spotify = "https://open.spotify.com/artist/27T030eWyCQRmDyuvr1kxY";
//                                    };
//                                    href = "https://api.spotify.com/v1/artists/27T030eWyCQRmDyuvr1kxY";
//                                    id = 27T030eWyCQRmDyuvr1kxY;
//                                    name = Scorpions;
//                                    type = artist;
//                                    uri = "spotify:artist:27T030eWyCQRmDyuvr1kxY";
//                                }
//                            );
//                            "available_markets" =                             (
//                                AU,
//                                AT,
//                                BE,
//                            );
//                            "disc_number" = 1;
//                            "duration_ms" = 575893;
//                            explicit = 0;
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/track/2xtgR153cWX3pWtrCcBc6x";
//                            };
//                            href = "https://api.spotify.com/v1/tracks/2xtgR153cWX3pWtrCcBc6x";
//                            id = 2xtgR153cWX3pWtrCcBc6x;
//                            "is_local" = 0;
//                            name = "Holiday (Demo Version)";
//                            "preview_url" = "https://p.scdn.co/mp3-preview/93c501490e339ca57ea63fc7c873f13e69bfb72a?cid=4a8e12d2b3734c14a6b7539ba30fe981";
//                            "track_number" = 10;
//                            type = track;
//                            uri = "spotify:track:2xtgR153cWX3pWtrCcBc6x";
//                        }
//                    );
//                    limit = 50;
//                    next = "<null>";
//                    offset = 0;
//                    previous = "<null>";
//                    total = 10;
//                };
//                type = album;
//                uri = "spotify:album:3Kd2XJF2ObCCLEhWOYMBHt";
//            };
//        }
//    );
//    limit = 1;
//    next = "https://api.spotify.com/v1/me/albums?offset=1&limit=1&locale=en-US,en;q=0.9";
//    offset = 0;
//    previous = "<null>";
//    total = 2;
//}
