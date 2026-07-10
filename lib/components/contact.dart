import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';
import 'icons.dart';

class Contact extends StatelessComponent {
  const Contact({required this.profile, super.key});

  final Profile profile;

  @override
  Component build(BuildContext context) {
    return footer(id: 'contact', classes: 'contact', [
      div(classes: 'section contact-in', [
        div(classes: 'contact-card reveal', [
          span(classes: 'contact-eyebrow', [.text('// contact')]),
          h2([.text('Let\'s ship something together')]),
          p([.text('Have an app idea, a role, or just want to talk mobile? My inbox is open.')]),
          if (profile.web3formsKey.isNotEmpty) ...[
            form(
              classes: 'cform',
              action: 'https://api.web3forms.com/submit',
              method: .post,
              [
                input(type: .hidden, name: 'access_key', value: profile.web3formsKey),
                input(type: .hidden, name: 'subject', value: 'New message via portfolio'),
                // Web3Forms honeypot: bots fill it, humans never see it.
                input(
                  type: .checkbox,
                  name: 'botcheck',
                  classes: 'cform-botcheck',
                  attributes: {'tabindex': '-1', 'autocomplete': 'off'},
                ),
                div(classes: 'cform-row', [
                  input(
                    type: .text,
                    name: 'name',
                    attributes: {'placeholder': 'Your name', 'required': '', 'autocomplete': 'name'},
                  ),
                  input(
                    type: .email,
                    name: 'email',
                    attributes: {'placeholder': 'your@email.com', 'required': '', 'autocomplete': 'email'},
                  ),
                ]),
                textarea(
                  name: 'message',
                  placeholder: 'What are we building?',
                  required: true,
                  rows: 5,
                  [],
                ),
                button(classes: 'btn btn-primary cform-send', type: .submit, [
                  .text('Send message'),
                  const Icon('arrow', size: 18),
                ]),
                p(classes: 'cform-status', attributes: {'aria-live': 'polite'}, []),
              ],
            ),
            a(classes: 'contact-alt', href: 'mailto:${profile.email}', [
              .text('or email me directly — ${profile.email}'),
            ]),
          ] else
            a(classes: 'btn btn-primary contact-btn', href: 'mailto:${profile.email}', [
              const Icon('mail', size: 18),
              .text(profile.email),
            ]),
          div(classes: 'contact-socials', [
            for (final MapEntry(key: name, value: url) in profile.socials.entries)
              a(href: url, target: .blank, [.text(name)]),
          ]),
        ]),
        div(classes: 'foot-note', [
          span([.text('© ${DateTime.now().year} ${profile.name}')]),
          span(classes: 'foot-built', [.text('Built with Jaspr (Dart) — content in markdown')]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.contact', [
      css('&').styles(
        border: .only(top: BorderSide.solid(color: Color('#33263D66'), width: 1.px)),
        raw: {
          'background':
              'radial-gradient(60% 80% at 50% 100%, #FFA96B14 0%, transparent 70%), radial-gradient(40% 60% at 80% 100%, #FF7A9C10 0%, transparent 70%)',
        },
      ),
      css('.contact-card').styles(
        display: .flex,
        flexDirection: .column,
        alignItems: .center,
        textAlign: .center,
      ),
      css('.contact-eyebrow').styles(
        color: T.accent2,
        fontFamily: T.mono,
        fontSize: 0.88.rem,
      ),
      css('h2').styles(
        maxWidth: .expression('22ch'),
        margin: .only(top: 0.8.rem),
        fontFamily: T.display,
        fontWeight: .w800,
        lineHeight: 1.15.em,
        raw: {'font-size': 'clamp(2rem, 5vw, 3.2rem)'},
      ),
      css('p').styles(
        maxWidth: 34.rem,
        margin: .only(top: 1.2.rem),
        color: T.muted,
        fontSize: 1.05.rem,
        lineHeight: 1.75.em,
      ),
      css('.contact-btn').styles(
        margin: .only(top: 2.2.rem),
      ),
      css('.cform', [
        css('&').styles(
          display: .flex,
          width: 100.percent,
          maxWidth: 36.rem,
          margin: .only(top: 2.4.rem),
          flexDirection: .column,
          gap: .all(0.9.rem),
          textAlign: .left,
        ),
        css('.cform-botcheck').styles(
          display: .none,
        ),
        css('.cform-row').styles(
          display: .grid,
          gap: .all(0.9.rem),
          raw: {'grid-template-columns': 'repeat(auto-fit, minmax(220px, 1fr))'},
        ),
        css('input, textarea').styles(
          width: 100.percent,
          padding: .symmetric(vertical: 0.85.rem, horizontal: 1.1.rem),
          border: .all(color: T.line, width: 1.px),
          radius: .circular(14.px),
          transition: Transition('border-color', duration: 200.ms),
          color: T.text,
          fontFamily: T.body,
          fontSize: 0.95.rem,
          backgroundColor: Color('#1A1420AA'),
        ),
        css('textarea').styles(
          raw: {'resize': 'vertical', 'min-height': '7rem'},
        ),
        css('input::placeholder, textarea::placeholder').styles(
          color: T.faint,
        ),
        css('input:focus, textarea:focus').styles(
          border: .all(color: Color('#FFA96B88'), width: 1.px),
          outline: Outline(style: .none),
        ),
        css('.cform-send', [
          css('&').styles(
            alignSelf: .start,
          ),
          css('&:disabled').styles(
            opacity: 0.6,
            pointerEvents: .none,
          ),
        ]),
        css('.cform-status', [
          css('&').styles(
            display: .none,
            margin: .zero,
            fontSize: 0.9.rem,
          ),
          css('&.ok').styles(
            display: .block,
            color: Color('#4ADE80'),
          ),
          css('&.err').styles(
            display: .block,
            color: Color('#F87171'),
          ),
        ]),
      ]),
      css('.contact-alt', [
        css('&').styles(
          margin: .only(top: 1.4.rem),
          color: T.faint,
          fontFamily: T.mono,
          fontSize: 0.83.rem,
        ),
        css('&:hover').styles(
          color: T.accent2,
        ),
      ]),
      css('.contact-socials', [
        css('&').styles(
          display: .flex,
          margin: .only(top: 2.rem),
          flexWrap: .wrap,
          justifyContent: .center,
          gap: .all(1.6.rem),
        ),
        css('a').styles(
          transition: Transition('color', duration: 200.ms),
          color: T.faint,
          fontFamily: T.mono,
          fontSize: 0.85.rem,
        ),
        css('a:hover').styles(
          color: T.accent2,
        ),
      ]),
      css('.foot-note').styles(
        display: .flex,
        margin: .only(top: 5.rem),
        flexWrap: .wrap,
        justifyContent: .spaceBetween,
        gap: .all(0.5.rem),
        color: T.faint,
        fontSize: 0.82.rem,
      ),
      css('.foot-built').styles(
        fontFamily: T.mono,
      ),
    ]),
  ];
}
