module Demo.Buttons exposing (Model,defaultModel,Msg(Mdl),update,view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Material
import Material.Button as Button
import Material.Options as Options exposing (styled, cs, css, when)
import Material.Typography as Typography
import String


type alias Model =
    { mdl : Material.Model
    }


defaultModel : Model
defaultModel =
    { mdl = Material.defaultModel
    }


type Msg m
    = Mdl (Material.Msg m)


update : (Msg m -> m) -> Msg m -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Mdl msg_ ->
            Material.update (Mdl >> lift) msg_ model


view : (Msg m -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Buttons"

    ( List.concat
      [
        [ Page.hero []
          [ Button.render (Mdl >> lift) [0,0] model.mdl
            [ Button.ripple
            , css "margin-right" "32px"
            ]
            [ text "Flat"
            ]
          , Button.render (Mdl >> lift) [0,1] model.mdl
            [ Button.ripple
            , Button.raised
            , Button.primary
            , css "margin-left" "32px"
            ]
            [ text "Raised"
            ]
          ]
        ]
      ,
        ( [ { headline = "Buttons", link = False, disabled = False, ripple = True }
          , { headline = "Without ripple", link = False, disabled = False, ripple = False }
          , { headline = "Links with Button Style", link = True, disabled = False, ripple = True }
          , { headline = "Disabled", link = False, disabled = True, ripple = True }
          ]
          |> List.concat << List.indexedMap (\rowIdx row ->
               ( List.concat
                 [ [ styled Html.div
                     [ Typography.title
                     , css "padding" "64px 16px 24px"
                     ]
                     [ text row.headline
                     ]
                   ]
                 , [ { dense = False, compact = False }
                   , { dense = True, compact = False }
                   , { dense = False, compact = True }
                   ]
                   |> List.map (\button ->
                          [ { dense = button.dense
                            , compact = button.compact
                            , raised = False
                            }
                          , { dense = button.dense
                            , compact = button.compact
                            , raised = True
                            }
                          ]
                      )
                   |> List.concat
                   |> List.indexedMap (\idx button ->
                        Button.render (Mdl >> lift) [2*(rowIdx+1), idx] model.mdl
                        [ css "margin" "16px"
                        , Button.link "#buttons" |> when row.link
                        , Button.disabled |> when row.disabled
                        , Button.raised |> when button.raised
                        , Button.ripple |> when row.ripple
                        , Button.compact |> when button.compact
                        , Button.dense |> when button.dense
                        ]
                        [ [ if button.dense then Just "Dense" else Nothing
                          , if button.compact then Just "Compact" else Nothing
                          , if button.raised then Just "Raised" else Just "Default"
                          ]
                          |> List.filterMap identity
                          |> String.join " "
                          |> text
                        ]
                      )
                 , [ { primary = False }
                   , { primary = True }
                   ]
                   |> List.map (\button ->
                          [ { primary = button.primary
                            , raised = False
                            }
                          , { primary = button.primary
                            , raised = True
                            }
                          ]
                      )
                   |> List.concat
                   |> List.indexedMap (\idx button ->
                        Button.render (Mdl >> lift) [2*(rowIdx+1) + 1, idx] model.mdl
                        [ css "margin" "16px"
                        , Button.link "#buttons" |> when row.link
                        , Button.disabled |> when row.disabled
                        , Button.ripple |> when row.ripple
                        , if button.primary then Button.primary
                            else
                              Button.accent
                        , Button.raised |> when button.raised
                        ]
                        [ [ if button.raised then "Raised" else "Default"
                          , "width"
                          , if button.primary then "Primary" else "Accent"
                          ]
                          |> String.join " "
                          |> text
                        ]
                      )
                 ]
               )
             )
        )
      ]
    )
