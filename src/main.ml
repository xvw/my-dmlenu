open Dmlenu

let colors =
  let open Ui.Colors in
  let open Draw in
  {
    normal_background = Color.of_string_exn "#000000"
  ; normal_foreground = Color.of_string_exn "#ffffff"
  ; focus_background = Color.of_string_exn "#222222"
  ; focus_foreground = Color.of_string_exn "#ffffff"
  ; match_foreground = Color.of_string_exn "#00ff00"
  ; window_background = Color.of_string_exn "#000000"
  }
;;

let program =
  let open Engine in
  {
    sources = [ Lazy.force Source.binaries ]
  ; transition = (fun o -> Dmlenu_extra.Sources.stm_from_file o.display)
  }
;;

let layout = State.MultiLine 4

let () =
  let () = Matching.(set_match_query_fun (subset ~case:false)) in
  let () = Ordering.(set_reorder_matched_fun prefixes_first) in
  match App.run ~layout ~colors program with
  | None -> ()
  | Some prog -> Unix.execv prog [||] |> ignore
;;
